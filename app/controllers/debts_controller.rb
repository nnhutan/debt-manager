# frozen_string_literal: true

# Debts Controller
class DebtsController < ApplicationController
  include DebtsHelper

  before_action :check_params, only: [:create]
  def index
    @debts = Debt.all
  end

  def show
    @debt = Debt.find(params[:id])
  end

  def new
    @debt = Debt.new
  end

  def create
    description = "#{debt_params[:description]} (#{debtors_in_description(debt_params[:debtor_id])})"
    debt_params[:debtor_id].each do |debtor_id|
      @debt = create_debt debtor_id, description
      @debt.save
    end
    flash[:success] = 'Debt created!'
    redirect_to debts_path
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
    params.require(:debt).permit(:total, :description, debtor_id: [])
  end
end
