# frozen_string_literal: true

# DebtorsController
class DebtorsController < ApplicationController
  before_action :check_login
  def index
    @debtors = Debtor.all.where(user_id: current_user.id)
  end

  def show
    @debtor = Debtor.find(params[:id])
    @lst_debts = @debtor.debts.where(user_id: current_user.id)
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

  def edit
    @debtor = Debtor.find_by(id: params[:id], user_id: current_user.id)
  end

  def update
    @debtor = Debtor.find_by(id: params[:id], user_id: current_user.id)
    if @debtor.update(debtor_params)
      flash[:success] = 'Update debtor successful!'
    else
      flash[:danger] = 'Update debtor failed!'
    end
    redirect_to debtors_path
  end

  def destroy
    @debtor = Debtor.find_by(id: params[:id], user_id: current_user.id)
    @debtor.destroy
    flash.now[:success] = 'Delete debtor successful!'
    redirect_to debtors_path, status: :see_other
  end

  private

  def debtor_params
    params.require(:debtor).permit(:full_name, :phone_number, :email)
  end
end
