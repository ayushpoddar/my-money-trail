# frozen_string_literal: true

require_relative "quick_add/backend/create_expense"
require_relative "quick_add/frontend/collect_expense_data"

module Composites
  module Transactions
    module QuickAdd
      extend self

      def create_expense(...)
        Backend::CreateExpense.new(...).call
      end

      def collect_expense_data(...)
        Frontend::CollectExpenseData.new(...).call
      end
    end
  end
end
