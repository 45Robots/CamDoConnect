class AddTotals < ActiveRecord::Migration
  def change
    [:xero_invoices, :shopify_orders].each do |table|
      add_column table, :sub_total, :float
      add_column table, :total, :float
    end
  end
end
