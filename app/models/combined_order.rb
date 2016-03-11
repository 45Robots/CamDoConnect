class CombinedOrder < ActiveRecord::Base

  scope :older_than, ->(time) {where('shopify_updated_at < ?', time)}

  scope :fulfilled, ->{where(shopify_status: 'fulfilled', shipwire_status: ['completed', 'delivered'], xero_status: 'PAID')}
  scope :xero_wtf,  ->{where(xero_identifier: nil).where.not(shopify_status: nil, shipwire_status: nil)}
  scope :yarin, ->{ where(shopify_status: nil, xero_status: nil) }
  scope :returns, ->{where(shipwire_status: 'returned')}
  scope :open_orders, ->{where(shopify_status: nil, shipwire_status: 'submitted', xero_status: 'PAID')}
  scope :back_orders, ->{where(shipwire_status: 'held')}
  scope :investigate, ->{where(shopify_status: nil, shipwire_status: ['delivered', 'complete', xero_status: 'PAID'])}


  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: true)
  end

  self.primary_key = :id

  belongs_to :shopify_order
  belongs_to :shipwire_order
  belongs_to :xero_invoice

  delegate :payload, to: :shopify_order, prefix: :shopify_order, allow_nil: true
  delegate :payload, :total_shipping, to: :shipwire_order, prefix: :shipwire_order, allow_nil: true

  def total_shipping
    paylod.dig('pricing', 'resource', 'total')
  end

  def shipwire_duration
    return unless shipwire_shipped_at.present?
    (shipwire_shipped_at - shipwire_accepted_at).to_i / 60 / 60
  end

  def destroy
    shopify_order&.destroy
    shipwire_order&.destroy
    xero_invoice&.destroy
  end

  private

  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end

end
