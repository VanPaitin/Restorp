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

ActiveRecord::Schema.define(version: 2018_10_24_125659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blacklists", force: :cascade do |t|
    t.string "jti"
    t.datetime "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_blacklists_on_jti"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "url_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cuisines", force: :cascade do |t|
    t.string "name"
    t.string "url_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cuisines_restaurants", id: false, force: :cascade do |t|
    t.bigint "cuisine_id", null: false
    t.bigint "restaurant_id", null: false
    t.index ["cuisine_id"], name: "index_cuisines_restaurants_on_cuisine_id"
    t.index ["restaurant_id"], name: "index_cuisines_restaurants_on_restaurant_id"
  end

  create_table "meal_orders", force: :cascade do |t|
    t.bigint "meal_id"
    t.bigint "order_id"
    t.integer "quantity"
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_meal_orders_on_meal_id"
    t.index ["order_id"], name: "index_meal_orders_on_order_id"
  end

  create_table "meals", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "number_in_stock"
    t.decimal "price"
    t.bigint "restaurant_id"
    t.bigint "cuisine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lock_version", default: 0
    t.index ["cuisine_id"], name: "index_meals_on_cuisine_id"
    t.index ["restaurant_id"], name: "index_meals_on_restaurant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.decimal "total_price"
    t.string "status", default: "pending"
    t.string "tracking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tracking_id"], name: "index_orders_on_tracking_id", unique: true
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.bigint "city_id"
    t.boolean "is_active"
    t.string "name"
    t.string "description"
    t.string "logo"
    t.integer "rating"
    t.integer "review_number"
    t.string "address"
    t.integer "post_code"
    t.float "latitude"
    t.float "longitude"
    t.boolean "is_delivery_enabled"
    t.boolean "is_pickup_enabled"
    t.boolean "is_preorder_enabled"
    t.string "web_path"
    t.string "url_key"
    t.boolean "is_new"
    t.jsonb "schedules"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_restaurants_on_city_id"
    t.index ["schedules"], name: "index_restaurants_on_schedules", using: :gin
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "meal_orders", "meals"
  add_foreign_key "meal_orders", "orders"
  add_foreign_key "meals", "cuisines"
  add_foreign_key "meals", "restaurants"
  add_foreign_key "orders", "users"
  add_foreign_key "restaurants", "cities"
end
