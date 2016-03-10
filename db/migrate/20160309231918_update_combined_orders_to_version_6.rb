class UpdateCombinedOrdersToVersion6 < ActiveRecord::Migration
  def change
    update_view :combined_orders, version: 6, revert_to_version: 5,  materialized: true
  end
end
