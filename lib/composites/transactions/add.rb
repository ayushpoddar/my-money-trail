# frozen_string_literal: true

require_relative "add/backend/create_transaction"
require_relative "add/frontend/collect_expense_data"

module Composites
  module Transactions
    module Add
      extend self

      def create_transaction(...)
        Backend::CreateTransaction.new(...).call
      end

      def collect_expense_data(...)
        Frontend::CollectExpenseData.new(...).call
      end
    end
  end
end
