class UpdateShopifyJob < ActiveJob::Base
  queue_as :default

  def perform(time = ShopifyOrder.most_recent_updated_at)
    time ||= Time.now.last_year
    shop_url = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_PASSWORD']}@camdotest.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    limit = 250
    page = 1
    params = {updated_at_min: time.utc.iso8601, limit: limit, status: :any}
    count = ShopifyAPI::Order.count(params)
    orders = []
    if count > 0
      page += count.divmod(limit).first
      while page > 0
        orders += ShopifyAPI::Order.all(params: params.merge(page: page))
        page -=1
      end
    end
    orders.each do |order|
      so = ShopifyOrder.find_or_create_by(order_id: order.id)
      so.update_attributes payload: order.to_json
    end
  end
end
