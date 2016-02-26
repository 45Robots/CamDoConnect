# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160223164754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "shipwire_orders", force: :cascade do |t|
    t.integer  "order_id",           limit: 8
    t.jsonb    "payload"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "order_updated_at"
    t.integer  "common_id",          limit: 8
    t.string   "shopify_id"
    t.string   "fulfillment_status"
    t.float    "subtotal"
    t.float    "shipping_amount"
    t.integer  "units"
    t.float    "total_shipping"
  end

  create_table "shopify_orders", force: :cascade do |t|
    t.integer  "order_id",           limit: 8
    t.jsonb    "payload"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "order_updated_at"
    t.integer  "common_id",          limit: 8
    t.string   "shopify_id"
    t.string   "fulfillment_status"
    t.float    "subtotal"
    t.float    "shipping_amount"
    t.integer  "units"
    t.float    "total_shipping"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree


  create_view :combined_orders,  sql_definition: <<-SQL
      SELECT shipwire_orders.id,
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
     FROM (shipwire_orders
       LEFT JOIN shopify_orders ON (((shipwire_orders.shopify_id)::text ~~* ((shopify_orders.shopify_id)::text || '%'::text))));
  SQL

end
