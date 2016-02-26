class CreateCombinedOrders < ActiveRecord::Migration
  def change
    create_view :combined_orders
  end
end
