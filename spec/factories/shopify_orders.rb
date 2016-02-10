FactoryGirl.define do
  factory :shopify_order, class: 'Shopify::Order' do
    order_id 1
    json_payload ""
  end
end
