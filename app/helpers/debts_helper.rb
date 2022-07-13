# frozen_string_literal: true

# Debts Helper
module DebtsHelper
  def debtors_in_description(debtor_ids)
    Debtor.select(:full_name).where(id: debtor_ids).map(&:full_name).join(', ')
  end

  def save_transaction(total, description)
    Transaction.create({ amount: total, description:, user_id: current_user.id })
  end

  def format_description
    "#{debt_params[:description]} (#{debt_params[:with_you] == '1' ? 'You and ' : ''}"\
    "#{debtors_in_description(debt_params[:debtor_id])})"
  end

  def amount_per_person
    num_people = debt_params[:debtor_id].size
    num_people += 1 if debt_params[:with_you] == '1'
    (debt_params[:total].to_i / num_people).round
  end

  def create_debt(debtor_id, description, total)
    current_user.debts.build({ debtor_id:, total:, description:, with_you: debt_params[:with_you] })
  end
end
