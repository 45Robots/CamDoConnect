class UpdateCombinedOrdersToVersion4 < ActiveRecord::Migration
  def change
    update_view :combined_orders, version: 4, revert_to_version: 3
  end
end
