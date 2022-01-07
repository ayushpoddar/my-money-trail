# frozen_string_literal: true

# t.string "summary"
# t.datetime "performed_at"
# t.string "status"
# t.string "transaction_id"
# t.float "amount"
# t.string "direction"
# t.integer "account_id"

require_relative "helpers/enumable"

class AccountTransaction < ApplicationRecord

  module Direction
    EXPENSE = "expense"
    INCOME  = "income"
  end

  module Status
    AWAITING_CONFIRMATION = "awaiting_confirmation"
    CONFIRMED             = "confirmed"
  end


  extend Enumable

  enumify :direction, Direction
  enumify :status,    Status

  # Setting default value for status column
  attribute :status, :string, default: -> { Status::AWAITING_CONFIRMATION }

  # Validations
  #############
  validates :performed_at, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :direction, presence: true
  validates :status, presence: true
  
  # Associations
  ##############
  belongs_to :account, inverse_of: :account_transactions
  has_and_belongs_to_many :transactions, join_table: :transaction_relations
end
