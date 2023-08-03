# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_03_155628) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_tea_subscriptions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "tea_id", null: false
    t.bigint "subscription_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["customer_id"], name: "index_customer_tea_subscriptions_on_customer_id"
    t.index ["subscription_id"], name: "index_customer_tea_subscriptions_on_subscription_id"
    t.index ["tea_id"], name: "index_customer_tea_subscriptions_on_tea_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.float "price"
    t.integer "plan_length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teas", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "brew_temp_f"
    t.integer "brew_time_min"
    t.integer "brew_time_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "customer_tea_subscriptions", "customers"
  add_foreign_key "customer_tea_subscriptions", "subscriptions"
  add_foreign_key "customer_tea_subscriptions", "teas"
end
