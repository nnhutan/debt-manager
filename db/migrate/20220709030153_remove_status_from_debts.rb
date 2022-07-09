# frozen_string_literal: true

class RemoveStatusFromDebts < ActiveRecord::Migration[7.0]
  def change
    remove_column :debts, :status, :boolean
  end
end
