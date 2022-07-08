# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def check_login
    return if logged_in?

    flash[:danger] = 'Please log in.'
    redirect_to login_url, status: :see_other
  end
end
