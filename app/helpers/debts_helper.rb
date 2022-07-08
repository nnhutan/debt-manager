# frozen_string_literal: true

module DebtsHelper
  def debtors_in_description(debtor_ids)
    Debtor.select(:full_name).where(id: debtor_ids).reduce('') { |x, y| "#{x}, #{y[:full_name]}" }
  end

  def create_debt(debtor_id, description)
    total = (debt_params[:total].to_i / debt_params[:debtor_id].size).round
    current_user.debts.build({ debtor_id:, total:, description:, status: 0 })
  end
end
