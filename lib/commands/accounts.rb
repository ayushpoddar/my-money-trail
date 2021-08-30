# frozen_string_literal: true

require_relative "../helpers/input"

module Commands
  module Accounts
    include Input

    COMMANDS = {
      "add" => -> { add }
    }

    extend self

    def add
      data = collect_info do
        input :name, required: true
        input :initial_balance, required: true
      end
    end
  end
end
