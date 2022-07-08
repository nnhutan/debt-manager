# frozen_string_literal: true

class Debt < ApplicationRecord
  belongs_to :user
  belongs_to :debtor
  validates :total, presence: true
  validates :debtor_id, presence: true
  validates :user_id, presence: true
end
