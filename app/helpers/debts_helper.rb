module DebtsHelper
  def create_debt(debtor_id)
    total = (debt_params[:total].to_i / debt_params[:debtor_id].size).round
    current_user.debts.build({ debtor_id:, total:, description: debt_params[:description],
                               status: 0 })
  end
end
