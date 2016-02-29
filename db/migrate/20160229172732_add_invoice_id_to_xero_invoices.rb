class AddInvoiceIdToXeroInvoices < ActiveRecord::Migration
  def change
    add_column :xero_invoices, :invoice_id, :string
    add_column :xero_invoices, :order_updated_at, :datetime
  end
end
