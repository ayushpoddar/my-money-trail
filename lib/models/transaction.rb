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
  IN_DIRECTION = "in"
  OUT_DIRECTION = "out"
  TRANSFER_DIRECTION = "transfer"
  DIRECTIONS = [IN_DIRECTION OUT_DIRECTION TRANSFER_DIRECTION].freeze

  # Validations
  #############
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :direction, presence: true, inclusion: { in: DIRECTIONS }
  validates :performed_at, presence: true

  # Associations
  ##############
  belongs_to :event, inverse_of: :transactions, optional: true

  # Scopes
  ########
  scope :transfer, -> { where(direction: TRANSFER_DIRECTION) }
  scope :not_transfer, -> { where.not(direction: TRANSFER_DIRECTION) }
  scope :expense, -> { where(direction: OUT_DIRECTION) }
  scope :income, -> { where(direction: IN_DIRECTION) }

  # Instance Methods
  ##################
  #
  def expense?
    direction == OUT_DIRECTION
  end

  def income?
    direction == IN_DIRECTION
  end

  def transfer?
    direction == TRANSFER_DIRECTION
  end
end
