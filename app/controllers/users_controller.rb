# frozen_string_literal: true

# User Controller
class UsersController < ApplicationController
  before_action :check_login, only: [:index]
  def index
    @debtors = current_user.debtors
    @transactions = current_user.transactions
  end

  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Sign up successful!'
      redirect_to login_path
    else
      puts @user.errors.inspect
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end
end
