class CreateShopifyOrders < ActiveRecord::Migration
  def change
    create_table :shopify_orders do |t|
      t.bigint :order_id
      t.jsonb :json_payload

      t.timestamps null: false
    end
  end
end
