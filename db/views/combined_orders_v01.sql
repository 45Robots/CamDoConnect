SELECT
  shipwire_orders.id AS id,
  shopify_orders.shopify_id AS shopify_id,
  shipwire_orders.shopify_id AS shipwire_shopify_id,
  shopify_orders.order_id AS shopify_order_id,
  shipwire_orders.order_id AS shipwire_order_id,
  shopify_orders.fulfillment_status AS shopify_status,
  shipwire_orders.fulfillment_status AS shipwire_status
FROM shipwire_orders
LEFT OUTER JOIN shopify_orders ON shipwire_orders.shopify_id ILIKE shopify_orders.shopify_id || '%'
