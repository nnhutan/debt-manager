class Debtor < ApplicationRecord
  belongs_to :user
  validates :full_name, presence: true, length: { maximum: 50 }
  validates :phone_number, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
end
