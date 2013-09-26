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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130926202833) do

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.decimal  "total"
    t.integer  "payerID"
    t.string   "code"
    t.text     "token"
    t.text     "payment_token"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "payments", :force => true do |t|
    t.string   "receiver_email"
    t.string   "notify_version"
    t.string   "transaction_id"
    t.string   "parent_txn_id"
    t.string   "receipt_id"
    t.string   "receiver_id"
    t.string   "resend"
    t.string   "residence_country"
    t.string   "test_ipn"
    t.string   "txn_type"
    t.string   "verify_sign"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
