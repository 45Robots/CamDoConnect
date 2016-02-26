SELECT
shipwire_orders.id AS id,
shopify_orders.shopify_id AS shopify_identifier,
shipwire_orders.shopify_id AS shipwire_identifier,
shopify_orders.id AS shopify_order_id,
shipwire_orders.id AS shipwire_order_id,
shopify_orders.fulfillment_status AS shopify_status,
shipwire_orders.fulfillment_status AS shipwire_status,
shopify_orders.order_updated_at AS shopify_updated_at,
shipwire_orders.order_updated_at AS shipwire_updated_at,
shopify_orders.total_shipping AS shopify_total_shipping,
shipwire_orders.total_shipping AS shipwire_total_shipping
FROM shipwire_orders
LEFT OUTER JOIN shopify_orders ON shipwire_orders.shopify_id ILIKE shopify_orders.shopify_id || '%'
