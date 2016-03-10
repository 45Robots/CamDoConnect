class UpdateCombinedOrdersToVersion7 < ActiveRecord::Migration
  def change
    update_view :combined_orders,
      version: 7,
      revert_to_version: 6,
      materialized: true
  end
end
