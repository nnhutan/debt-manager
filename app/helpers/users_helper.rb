# frozen_string_literal: true

module UsersHelper
  def format_money(amount)
    number_to_currency(amount, unit: 'VNĐ', delimiter: '.', precision: 0, format: '%n %u')
  end

  def total_amount_transaction
    format_money(Transaction.where(user_id: current_user.id).sum(:amount))
  end

  def total_amount_debt
    format_money(current_user.debts.sum(:total))
  end

  def total_debt
    current_user.debts.count
  end

  def total_debtor
    current_user.debtors.count
  end

  def total_debt_of_debtor(debtor_id)
    current_user.debts.where(debtor_id:).count
  end

  def total_amount_debt_of_debtor(debtor_id)
    format_money(current_user.debts.where(debtor_id:).sum(:total))
  end
end
