# frozen_string_literal: true

# Debts Helper
module DebtsHelper
  def debtors_in_description(debtor_ids)
    Debtor.select(:full_name).where(id: debtor_ids).reduce('') { |x, y| "#{x}, #{y[:full_name]}" }
  end

  def create_debt(debtor_id, description)
    num_people = debt_params[:debtor_id].size
    num_people += 1 if debt_params[:with_you]
    total = (debt_params[:total].to_i / num_people).round

    current_user.debts.build({ debtor_id:, total:, description:, with_you: debt_params[:with_you] })
  end
end
