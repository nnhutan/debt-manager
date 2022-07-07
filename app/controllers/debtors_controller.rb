class DebtorsController < ApplicationController
  def index
    @debtors = Debtor.all
  end

  def new
    @debtor = Debtor.new
  end

  def create
    @debtor = current_user.debtors.build(debtor_params)
    if @debtor.save
      redirect_to debtors_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def debtor_params
    params.require(:debtor).permit(:full_name, :phone_number, :email)
  end
end
