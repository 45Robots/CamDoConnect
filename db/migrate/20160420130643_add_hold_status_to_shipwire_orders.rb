class AddHoldStatusToShipwireOrders < ActiveRecord::Migration
  def change
    add_column :shipwire_orders, :hold_status, :string
  end
end
