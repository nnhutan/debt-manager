# frozen_string_literal: true

# TransactionsController
class TransactionsController < ApplicationController
  before_action :check_login
  def destroy
    # delete all transactions of current user
    Transaction.where(user_id: current_user.id).destroy_all
    redirect_to users_path, status: :see_other
  end
end
