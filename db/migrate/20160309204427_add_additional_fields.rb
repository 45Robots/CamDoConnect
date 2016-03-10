class AddAdditionalFields < ActiveRecord::Migration
  def change
    add_column :shopify_orders, :discount_total, :float
    add_column :shopify_orders, :paid_date, :date
    add_column :shipwire_orders, :accepted_at, :datetime
    add_column :shipwire_orders, :shipped_at, :datetime
  end
end
