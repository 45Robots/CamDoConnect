class UpdateXeroJob < ActiveJob::Base
  queue_as :default

  def perform(time = XeroInvoice.most_recent_updated_at)
     time ||= Time.now.last_year
     gateway = XeroGateway::PrivateApp.new(ENV['XERO_OAUTH_CONSUMER_KEY'], ENV['XERO_OAUTH_CONSUMER_SECRET'], ENV['XERO_PRIVATE_KEY_PATH'])
     invoices = gateway.get_invoices(:modified_since => time).response_item
     invoices.each do |invoice|
       next if invoice.accounts_payable?
       local_inv = XeroInvoice.find_or_create_by(invoice_id: invoice.invoice_id)
       local_inv.shopify_id = invoice.invoice_number
       local_inv.amount_due = invoice.amount_due
       local_inv.invoice_status = invoice.invoice_status
       local_inv.shopify_url = invoice.url
       local_inv.invoice_date = invoice.date
     end
  end
end
