# frozen_string_literal: true

# t.datetime "started_at"
# t.datetime "finished_at"
# t.datetime "created_at", null: false
# t.string "summary"

class Event < ApplicationRecord

  # Validations
  #############

  # Associations
  ##############
  has_many :transactions, inverse_of: :event

  # Scopes
  ########
  scope :recent_first, -> { order(created_at: :desc) }

end
