# frozen_string_literal: true

module UsersHelper
  def total_amount_debt
    current_user.debts.sum(:total)
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
    current_user.debts.where(debtor_id:).sum(:total)
  end
end
