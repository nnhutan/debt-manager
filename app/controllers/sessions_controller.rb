# frozen_string_literal: true

# Session Controller
class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    redirect_to root_url, status: :see_other if logged_in?
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session_params[:remember_me] == '1' ? remember(user) : forget(user)
      log_in user
      flash[:success] = 'Login successful!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_url, status: :see_other
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end
end
