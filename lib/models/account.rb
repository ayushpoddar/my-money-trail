# frozen_string_literal: true

# t.string "name", null: false
# t.float "initial_balance", default: 0.0
# t.boolean "is_deleted", default: false, null: false

class Account < ApplicationRecord

  # Validations
  #############
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :initial_balance, presence: true, numericality: true

  # Associations
  ##############
  has_many :account_transactions, inverse_of: :account
end
