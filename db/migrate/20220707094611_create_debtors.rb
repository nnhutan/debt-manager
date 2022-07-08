# frozen_string_literal: true

class CreateDebtors < ActiveRecord::Migration[7.0]
  def change
    create_table :debtors do |t|
      t.string :full_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
