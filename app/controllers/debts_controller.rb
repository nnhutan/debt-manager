# frozen_string_literal: true

# Debts Controller
class DebtsController < ApplicationController
  include DebtsHelper

  before_action :check_params, only: [:create]
  def index
    @debts = Debt.all.where(user_id: current_user[:id]).order(created_at: :desc)
  end

  def show
    @debt = Debt.find(params[:id])
  end

  def new
    @debt = Debt.new
  end

  def create
    description = "#{debt_params[:description]} (#{debt_params[:with_you] ? 'You and' : ''}\
    #{debtors_in_description(debt_params[:debtor_id])})"
    debt_params[:debtor_id].each do |debtor_id|
      @debt = create_debt debtor_id, description
      @debt.save
    end
    flash[:success] = 'Debt created!'
    redirect_to debts_path
  end

  def edit
    @debt = Debt.find(params[:id])
  end

  def update
    @debt = Debt.find(params[:id])
    if @debt.update(debt_params)
      flash[:success] = 'Debt updated!'
    else
      flash[:danger] = 'Debt not updated!'
    end
    redirect_to debts_path
  end

  def destroy
    puts debt_params
    @debt = Debt.find(params[:id])
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
