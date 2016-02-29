class ShopifyOrder < ActiveRecord::Base
  include MaxOrderUpdatedAt
  before_save :set_values

  private

  def set_values
    return if payload.nil?
    self.order_updated_at = payload.dig('updated_at')
    self.shopify_id = payload.dig('name')
    self.fulfillment_status = payload.dig('fulfillment_status')
    self.total_shipping = Array(payload.dig('shipping_lines')).map {|sl| sl['price']}.map(&:to_f).sum
    self.total = payload.dig('total_price')
    self.sub_total = payload.dig('subtotal_price')
  end
end
