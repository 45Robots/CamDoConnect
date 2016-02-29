class UpdateCombinedOrdersToVersion5 < ActiveRecord::Migration
  def change
    drop_view :combined_orders
    create_view :combined_orders,
      version: 5,
      materialized: true
    add_index :combined_orders, :id , unique: true
  end
end
