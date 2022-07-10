# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  attr_accessor :remember_token

  before_save :downcase_email
  has_many :debtors, dependent: :destroy
  has_many :debts, dependent: :destroy
  has_many :transactions, dependent: :destroy
  validates :full_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def digest_string(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(type, token)
    digest = send("#{type}_digest")
    puts digest
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def remember
    self.remember_token = new_token
    update_attribute(:remember_digest, digest_string(remember_token))
    remember_digest
  end

  def session_token
    remember_digest || remember
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
