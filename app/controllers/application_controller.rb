# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def check_login
    unless logged_in?
      flash[:danger] = 'Please log in.'
      redirect_to login_url, status: :see_other
    end
  end
end
