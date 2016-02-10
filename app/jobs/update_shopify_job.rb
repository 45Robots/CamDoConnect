class UpdateShopifyJob < ActiveJob::Base
  queue_as :default

  def perform
    shop_url = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_PASSWORD']}@camdotest.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url

  end
end
