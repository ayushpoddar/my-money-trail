class Account < ApplicationRecord

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :initial_balance, presence: true, numericality: true

  def add(params)
    account = ::Account.new(params)
    if account.save
      return_success
    else
      return_error
    end
  end
end
