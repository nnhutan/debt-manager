# frozen_string_literal: true

# Sessions helper
module SessionsHelper
  def log_in(user)
    session[:session_token] = user.session_token
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      @current_user = user if user&.session_token == session[:session_token]
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      puts user.inspect
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def log_out
    current_user.forget
    session[:session_token] = nil
  end
end
