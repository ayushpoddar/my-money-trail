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

ActiveRecord::Schema.define(version: 2022_01_09_161821) do

  create_table "account_transactions", force: :cascade do |t|
    t.string "summary"
    t.datetime "performed_at"
    t.string "status"
    t.string "transaction_id"
    t.float "amount"
    t.string "direction"
    t.integer "account_id"
    t.index ["account_id"], name: "index_account_transactions_on_account_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.float "initial_balance", default: 0.0
    t.boolean "is_deleted", default: false, null: false
    t.boolean "is_external", default: true
  end

  create_table "events", force: :cascade do |t|
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.string "summary"
    t.datetime "updated_at", null: false
  end

  create_table "transaction_relations", id: false, force: :cascade do |t|
    t.bigint "account_transaction_id"
    t.bigint "transaction_id"
    t.index ["account_transaction_id"], name: "index_transaction_relations_on_account_transaction_id"
    t.index ["transaction_id"], name: "index_transaction_relations_on_transaction_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "event_id"
    t.string "summary"
    t.datetime "performed_at", null: false
    t.float "amount", default: 0.0, null: false
    t.string "direction"
    t.index ["event_id"], name: "index_transactions_on_event_id"
  end

  add_foreign_key "account_transactions", "accounts"
  add_foreign_key "transactions", "events"
end
