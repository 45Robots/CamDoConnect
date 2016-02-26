class CreateShopifyOrders < ActiveRecord::Migration
  def change
    create_table :shopify_orders do |t|
      t.integer :order_id, limit: 8
      t.jsonb :payload

      t.timestamps null: false
    end
  end
end
