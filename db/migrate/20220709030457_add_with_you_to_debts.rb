# frozen_string_literal: true

class AddWithYouToDebts < ActiveRecord::Migration[7.0]
  def change
    add_column :debts, :with_you, :boolean
  end
end
