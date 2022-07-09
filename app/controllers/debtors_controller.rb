# frozen_string_literal: true

class DebtorsController < ApplicationController
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
    @debtor = Debtor.find(params[:id])
  end

  def update
    @debtor = Debtor.find(params[:id])
    if @debtor.update(debtor_params)
      flash[:success] = 'Update debtor successful!'
    else
      flash[:danger] = 'Update debtor failed!'
    end
    redirect_to debtors_path
  end

  def destroy
    @debtor = Debtor.find(params[:id])
    @debtor.destroy
    flash.now[:success] = 'Delete debtor successful!'
    redirect_to debtors_path, status: :see_other
  end

  private

  def debtor_params
    params.require(:debtor).permit(:full_name, :phone_number, :email)
  end
end
