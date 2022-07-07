class AddPhoneNumberToDebtors < ActiveRecord::Migration[7.0]
  def change
    add_column :debtors, :phone_number, :string
  end
end
