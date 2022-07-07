# frozen_string_literal: true

# Session Controller
class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Login successful!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy; end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
