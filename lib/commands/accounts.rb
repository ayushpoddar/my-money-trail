# frozen_string_literal: true

require_relative "../helpers/result_handler"

require_relative "../composites/accounts/add"
require_relative "../utils/errors"

module Commands
  module Accounts
    include ResultHandler

    COMMANDS = {
      add: -> { add }
    }.with_indifferent_access

    private

    extend self

    def add(data={})
      klass = Composites::Accounts::Add
      klass.collect_account_data(data)
        .save_value_as(:account)
        .and_then { |data| klass.create_account(data) }
        .on_success do |result, collected_data|
          handle_success("Account added", collected_data[:account].humanize)
        end
        .on_failure do |error, collected_data|
          handle_failure(error.message) do
            add(collected_data[:account])
          end
        end
    end
  end
end
