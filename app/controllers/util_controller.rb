# frozen_string_literal: true

class UtilController < ApplicationController
  include UsersHelper
  Mime::Type.register 'application/xls', :xls
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

  def export_all
    user_data = User.select('debtors.full_name as Debtor', 'total as amount', 'description', 'created_at').joins(:debtors,
                                                                                                                 :debts).where(
                                                                                                                   id: current_user[:id]
                                                                                                                 )
    respond_to do |format|
      format.html
      format.xls do
        filename = "#{current_user[:full_name]}_#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.xlsx"
        send_data(user_data.to_xls,
                  type: 'text/xls; charset=utf-8; header=present',
                  filename:)
      end
    end
  end

  def export_debtor
    debts = Debt.select('full_name', 'total', 'description', 'created_at').joins('INNER JOIN debtors ON debts.debtor_id = debtors.id').where(
      user_id: current_user[:id], debtor_id: params[:id]
    )
    respond_to do |format|
      format.html
      format.xls do
        filename = "debts_of_#{debts.first[:full_name]}_#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.xlsx"
        send_data(debts.to_xls,
                  type: 'text/xls; charset=utf-8; header=present',
                  filename:)
      end
    end
  end

  def export
    debts = Debt.select('full_name', 'total', 'description',
                        'created_at').joins('INNER JOIN debtors ON debts.debtor_id = debtors.id').where(user_id: current_user[:id])
    respond_to do |format|
      format.html
      format.xls do
        filename = "debts_#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.xlsx"
        send_data(debts.to_xls,
                  type: 'text/xls; charset=utf-8; header=present',
                  filename:)
      end
    end
  end
end
