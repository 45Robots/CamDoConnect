ActiveAdmin.register CombinedOrder do

  config.per_page = 100
  config.sort_order = 'shipwire_updated_at_desc'
  actions :index, :show

  preserve_default_filters!
  remove_filter :id, :shopify_order, :shipwire_order, :xero_invoice, :shopify_identifier, :xero_identifier

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
    column :xero_sub_total
    column :shopify_total
    column :xero_total
    column :shipwire_updated_at, label: "Updated At"
    actions
  end

  show do
    columns do
      column do
        panel "Shopify" do
          div do
            "#{combined_order.shopify_identifier}/#{combined_order.shopify_status}" if combined_order.shopify_order
          end
          div do
            render 'hash', { hash: combined_order.shopify_order_payload }
          end
        end
      end
      column do
        panel "Shipwire" do
          div do
            "#{combined_order.shipwire_identifier}/#{combined_order.shipwire_status}"
          end
          div do
            render 'hash', { hash: combined_order.shipwire_order_payload }
          end
        end
      end
    end
    active_admin_comments
  end

end
