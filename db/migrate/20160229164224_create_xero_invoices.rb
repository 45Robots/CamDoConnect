class CreateXeroInvoices < ActiveRecord::Migration
  def change
    create_table :xero_invoices do |t|
      t.string :shopify_id
      t.string :invoice_status
      t.string :invoice_type
      t.float :amount_due
      t.string :shopify_url
      t.date :invoice_date

      t.timestamps null: false
    end
  end
end
