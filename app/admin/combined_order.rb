ActiveAdmin.register CombinedOrder, as: "Order" do
  #menu label: "All Orders"

  config.per_page = 100
  config.sort_order = 'shipwire_updated_at_desc'
  actions :index, :show

  preserve_default_filters!
  remove_filter :id, :shopify_order, :shipwire_order, :xero_invoice, :shopify_identifier, :xero_identifier

  scope :all, default: true
  CombinedOrder.specific_cases.each {|specific_case| scope specific_case}
  scope :other_cases

  index do
    column :shopify_identifier
    column :shipwire_identifier
    column :xero_identifier
    column :shopify_status
    column :shipwire_status
    column :xero_status
    column :shopify_total_shipping
    column :shipwire_total_shipping
    column :shopify_sub_total
    column :shopify_discount_total
    column :xero_sub_total
    column :shopify_total
    column :xero_total
    column :shopify_paid_date
    column :shipwire_accepted_at
    column :shipwire_shipped_at
    column :shipwire_duration
    column :shipwire_hold_status
    column "Updated at", :shipwire_updated_at
    actions
  end

  show do
    columns do
      column do
        panel "Shopify" do
          div do
            "#{order.shopify_identifier}/#{order.shopify_status}" if order.shopify_order
          end
          div do
            render 'hash', { hash: order.shopify_order_payload }
          end
        end
      end
      column do
        panel "Shipwire" do
          div do
            "#{order.shipwire_identifier}/#{order.shipwire_status}"
          end
          div do
            render 'hash', { hash: order.shipwire_order_payload }
          end
        end
      end
    end
    active_admin_comments
  end

end


