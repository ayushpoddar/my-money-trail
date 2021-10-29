# frozen_string_literal: true

class Account < ApplicationRecord

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :initial_balance, presence: true, numericality: true

  class << self

    def add(params)
      account = self.new(params)
      if account.save
        account.return_success
      else
        account.return_error
      end
    end

  end
end
