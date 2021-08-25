# frozen_string_literal: true

module Commands
  class Account
    include Commands

    VALID_ACCOUNT_ATTRIBUTES = %i[name initial_balance]

    def add(params)
      puts params
      params = params.with_indifferent_access.slice(*VALID_ACCOUNT_ATTRIBUTES)
      puts params
      account = ::Account.new(params)
      if account.save
        return_success account
      else
        return_error account
      end
    end
  end
end
