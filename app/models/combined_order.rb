class CombinedOrder < ActiveRecord::Base

  has_many :comments, as: 'resource', class_name: 'ActiveAdmin::Comment', dependent: :destroy

  scope :older_than, ->(time) {where('shipwire_updated_at < ?', time)}
  scope :without_comment, ->{joins('left join active_admin_comments on combined_orders.id::varchar = active_admin_comments.resource_id').where(active_admin_comments: {id: nil})}

  scope :fulfilled, ->{where(shopify_status: 'fulfilled', shipwire_status: ['completed', 'delivered'], xero_status: 'PAID')}
  scope :xero_wtf,  ->{without_comment.where(xero_identifier: nil).where.not(shopify_status: nil, shipwire_status: [nil, 'cancelled', 'held'])}
  scope :customer_service, ->{ without_comment.where(shopify_identifier: nil, xero_identifier: nil) }
  scope :returns, ->{without_comment.where(shipwire_status: 'returned')}
  scope :open_orders, ->{without_comment.where(shopify_status: nil, shipwire_status: 'submitted', xero_status: 'PAID')}
  scope :back_orders, ->{without_comment.where(shipwire_hold_status: 'backorder')}
  scope :investigate, ->{without_comment.where(shopify_status: nil, shipwire_status: ['delivered', 'complete'], xero_status: 'PAID')}

  def self.specific_cases
    [:fulfilled, :xero_wtf, :customer_service, :returns, :open_orders, :back_orders, :investigate]
  end

  def self.other_cases
     ids = specific_cases.map {|scope| self.send(scope).pluck(:id)}.flatten.uniq
     without_comment.where.not(id: ids).where.not(shipwire_status: 'cancelled')
  end

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
