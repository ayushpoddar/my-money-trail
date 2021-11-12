# frozen_string_literal: true

require_relative "add/backend/create_account"
require_relative "add/frontend/collect_account_data"

module Composites
  module Accounts
    module Add
      extend self

      def create_account(...)
        Backend::CreateAccount.new(...).call
      end

      def collect_account_data(...)
        Frontend::CollectAccountData.new(...).call
      end
    end
  end
end
