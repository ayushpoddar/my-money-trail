# frozen_string_literal: true

module Commands
  module Accounts
    COMMANDS = {
      "add" => -> { add }
    }

    extend self

    def add
      puts "I am in add"
    end
  end
end
