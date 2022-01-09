# frozen_string_literal: true

# t.string "name", null: false
# t.float "initial_balance", default: 0.0
# t.boolean "is_deleted", default: false, null: false
# t.boolean "is_external", default: true
# t.string "description"

class Account < ApplicationRecord

  # Validations
  #############
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :initial_balance, presence: true, numericality: true

  # Associations
  ##############
  has_many :account_transactions, inverse_of: :account

  # Scopes
  ########
  scope :internal, -> { where(is_external: false) }
  scope :external, -> { where(is_external: true) }

  # Instance methods
  ##################
  def external?
    is_external?
  end

  def internal?
    !external?
  end
end
