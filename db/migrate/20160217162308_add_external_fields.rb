class AddExternalFields < ActiveRecord::Migration
  def change
    [:shopify_orders, :shipwire_orders].each do |table|
      add_column table, :order_updated_at, :datetime
      add_column table, :common_id, :integer, limit: 8
      add_column table, :shopify_id, :string
      add_column table, :fulfillment_status, :string
      add_column table, :subtotal, :float
      add_column table, :shipping_amount, :float
      add_column table, :units, :integer
    end
  end
end
