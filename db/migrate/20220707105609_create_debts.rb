# frozen_string_literal: true

class CreateDebts < ActiveRecord::Migration[7.0]
  def change
    create_table :debts do |t|
      t.integer :total
      t.text :description
      t.boolean :status
      t.references :user, null: false, foreign_key: true
      t.references :debtor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
