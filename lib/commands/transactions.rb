# frozen_string_literal: true

require_relative "../helpers/result_handler"

require_relative "../composites/transactions/quick_add"
require_relative "../utils/errors"

module Commands
  module Transactions
    include ResultHandler

    COMMANDS = {
      quick_add_expense: -> { quick_add }
    }.with_indifferent_access

    private

    extend self

    def quick_add(data={})
      klass = Composites::Transactions::QuickAdd
      klass.collect_expense_data(data)
        .save_value_as(:expense)
        .and_then { |data| klass.create_expense(data) }
        .on_success do |result, collected_data|
          handle_success("Expense added", collected_data[:expense].humanize)
        end
        .on_failure do |error, collected_data|
          handle_failure(error.message) do
            quick_add(collected_data[:expense])
          end
        end
    end

  end
end
