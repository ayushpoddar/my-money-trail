# frozen_string_literal: true

require_relative "../helpers/input"
require_relative "../helpers/result_handler"

module Commands
  module Accounts
    include Input
    include ResultHandler

    COMMANDS = {
      add: -> { add }
    }.with_indifferent_access

    extend self

    def add(values={})
      data = collect_info(values) do
        input :name, required: true, label: "Please enter the account name"
        input :initial_balance, required: true, convert: :float, label: "Please enter this account's initial balance"
      end
      result = Account.add(data)
      ultimate_handler(
        result,
        failure_callback: lambda { add(data) }
      )
    end
  end
end
