class Account < ApplicationRecord

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :initial_balance, presence: true, numericality: true
end
