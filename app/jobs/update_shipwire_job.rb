class UpdateShipwireJob < ActiveJob::Base
  queue_as :default

  def perform(time = ShipwireOrder.most_recent_updated_at)
    time ||= Time.now.last_year
    ShipwireAPI::Orders.new(since: time.utc.iso8601).orders.each do |order|
      swo = ShipwireOrder.find_or_create_by(order_id: order.id)
      swo.update_attributes payload: order.to_json
    end
  end
end
