class CombinedOrder < ActiveRecord::Base
  self.primary_key = :id

  belongs_to :shopify_order
  belongs_to :shipwire_order
  belongs_to :xero_invoice

  delegate :payload, to: :shopify_order, prefix: :shopify_order, allow_nil: true
  delegate :payload, :total_shipping, to: :shipwire_order, prefix: :shipwire_order, allow_nil: true

  def total_shipping
    paylod.dig('pricing', 'resource', 'total')
  end

  private

  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end
end
