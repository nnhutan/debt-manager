# frozen_string_literal: true

# Debts Controller
class DebtsController < ApplicationController
  before_action :check_login
  before_action :check_params, only: [:create]
  include DebtsHelper
  def index
    @debts = Debt.all.where(user_id: current_user[:id]).order(created_at: :desc)
  end

  def show
    @debt = Debt.find_by(params[:id], user_id: current_user[:id])
  end

  def new
    @debt = Debt.new
  end

  def create
    description = format_description
    total = amount_per_person
    debt_params[:debtor_id].each do |debtor_id|
      @debt = create_debt debtor_id, description, total
      @debt.save
    end
    save_transaction(total, description) if debt_params[:with_you] == '1'
    flash[:success] = 'Debt created!'
    redirect_to debts_path
  end

  def edit
    @debt = Debt.find_by(params[:id], user_id: current_user[:id])
  end

  def update
    @debt = Debt.find_by(params[:id], user_id: current_user[:id])
    if @debt.update(debt_params)
      flash[:success] = 'Debt updated!'
    else
      flash[:danger] = 'Debt not updated!'
    end
    redirect_to debts_path
  end

  def destroy
    @debt = Debt.find_by(params[:id], user_id: current_user[:id])
    @debt.destroy
    flash[:success] = 'Debt deleted!'
    redirect_to debts_path, status: :see_other
  end

  private

  def check_params
    debtor_id = debt_params[:debtor_id]
    total = debt_params[:total] != ''
    return if debtor_id && total

    flash[:danger] =
      "#{!total && 'Please enter total amount!' || ''} #{!debtor_id && 'Please select at least one debtor!' || ''}"
    redirect_to new_debt_path
    # render :new, status: :unprocessable_entity
  end

  def debt_params
    params.require(:debt).permit(:total, :description, :with_you, debtor_id: [])
  end
end
