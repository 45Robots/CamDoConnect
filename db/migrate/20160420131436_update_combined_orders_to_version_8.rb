class UpdateCombinedOrdersToVersion8 < ActiveRecord::Migration
  def change
    update_view :combined_orders,
      version: 8,
      revert_to_version: 7,
      materialized: true
  end
end
