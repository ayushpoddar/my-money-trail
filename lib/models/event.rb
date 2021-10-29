# frozen_string_literal: true

class Event < ApplicationRecord

  # Validations
  #############
  validates :details, presence: true

  # Associations
  ##############
  has_many :transactions, inverse_of: :event

  # Scopes
  ########
  scope :recent_first, -> { order(created_at: :desc) }

end
