class AddEmailToDebtors < ActiveRecord::Migration[7.0]
  def change
    add_column :debtors, :email, :string
  end
end
