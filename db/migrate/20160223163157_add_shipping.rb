class AddShipping < ActiveRecord::Migration
  def change
    [:shopify_orders, :shipwire_orders].each do |table|
      add_column table, :total_shipping, :float
    end
  end
end
