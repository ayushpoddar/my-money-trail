# frozen_string_literal: true

# t.integer "event_id"
# t.string "summary"
# t.datetime "performed_at", null: false
# t.float "amount", default: 0.0, null: false
# t.string "direction"

class Transaction < ApplicationRecord
  # The meaning of each direction are:
  # in: Money coming in; I am earning
  # out: Money going out; I am expending
  # transfer: Money being transferred from one account to other
  module Direction
    EXPENSE = "expense"
    INCOME = "income"
    TRANSFER = "transfer"
  end

  enum direction: Direction.constants.map { |c|
    value = Direction.const_get(c)
    [value, value]
  }.to_h

  # Validations
  #############
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :direction, presence: true
  validates :performed_at, presence: true

  # Associations
  ##############
  belongs_to :event, inverse_of: :transactions, optional: true

  # Scopes
  ########

  # Instance Methods
  ##################
  #
end
