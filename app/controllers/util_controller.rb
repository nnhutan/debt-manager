# frozen_string_literal: true

class UtilController < ApplicationController
  include UsersHelper
  def aggregate
    # get all debtors of current user
    debtors = current_user.debtors
    debtors.each do |debtor|
      # get all debts of current user
      total = total_amount_debt_of_debtor(debtor[:id])
      debt = { debtor_id: debtor[:id], total:,
               description: "Final of #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}", user_id: current_user[:id],
               with_you: 0 }
      Debt.delete(Debt.where(debtor_id: debtor[:id], user_id: current_user[:id]))
      Debt.create(debt)
    end
    flash[:success] = 'Aggregate debts successfull!'
    redirect_to root_path, status: :see_other
  end

  def reset
    Debt.delete(Debt.where(user_id: current_user[:id]))
    flash[:success] = 'Reset debts successfull!'
    redirect_to root_path, status: :see_other
  end

  def welcome
    redirect_to users_path, status: :see_other if logged_in?
  end
end
