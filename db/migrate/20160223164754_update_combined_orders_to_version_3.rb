class UpdateCombinedOrdersToVersion3 < ActiveRecord::Migration
  def change
    update_view :combined_orders, version: 3, revert_to_version: 2
  end
end
