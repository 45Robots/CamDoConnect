class UpdateCombinedOrdersToVersion2 < ActiveRecord::Migration
  def change
    update_view :combined_orders, version: 2, revert_to_version: 1
  end
end
