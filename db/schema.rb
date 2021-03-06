# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_220_710_064_647) do
  create_table 'debtors', force: :cascade do |t|
    t.string 'full_name'
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'email'
    t.string 'phone_number'
    t.index ['user_id'], name: 'index_debtors_on_user_id'
  end

  create_table 'debts', force: :cascade do |t|
    t.integer 'total'
    t.text 'description'
    t.integer 'user_id', null: false
    t.integer 'debtor_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'with_you'
    t.index ['debtor_id'], name: 'index_debts_on_debtor_id'
    t.index ['user_id'], name: 'index_debts_on_user_id'
  end

  create_table 'transactions', force: :cascade do |t|
    t.integer 'amount'
    t.text 'description'
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_transactions_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'full_name'
    t.string 'email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'password_digest'
    t.string 'remember_digest'
  end

  add_foreign_key 'debtors', 'users'
  add_foreign_key 'debts', 'debtors'
  add_foreign_key 'debts', 'users'
  add_foreign_key 'transactions', 'users'
end
