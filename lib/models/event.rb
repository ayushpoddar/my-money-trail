# frozen_string_literal: true

# t.datetime "started_at"
# t.datetime "finished_at"
# t.string "summary"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false

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
