class ShipwireOrder < ActiveRecord::Base
  include MaxOrderUpdatedAt

  before_save :set_values

  private

  def set_values
    return if payload.nil?
    self.order_updated_at = payload.dig('lastUpdatedDate')
    self.shopify_id = payload.dig('orderNo')
    self.fulfillment_status = payload.dig('status')
    self.total_shipping = payload.dig('pricing', 'resource', 'total')
    self.accepted_at = payload.dig('events', 'resource', 'createdDate')
    self.shipped_at = payload.dig('events', 'resource', 'completedDate')
  end

end
