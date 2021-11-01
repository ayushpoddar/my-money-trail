# frozen_string_literal: true

require_relative "helpers/input"
require_relative "helpers/printer"

require_relative "commands/accounts"
require_relative "commands/transactions"

module Commands
  include Input
  include Printer

  COMMAND_SECTORS = {
    accounts:     Commands::Accounts,
    transactions: Commands::Transactions
  }.with_indifferent_access

  EXTRA_COMMANDS = %w[exit]

  extend self

  def get_command
    info_text = "Please select a command. Choose \"exit\" to exit."
    cmd = select_option(info_text, commands).first
    case cmd
    when "exit"
      print_success("Bye!")
    when nil
      print_success("Bye!")
    else
      call_sector_command(cmd)
    end
  end

  private

  def call_sector_command(cmd)
    sector, sub_command = cmd.split(".")
    command_module = COMMAND_SECTORS[sector]
    command_module::COMMANDS[sub_command].call
  end

  def commands
    cmds = COMMAND_SECTORS.map do |sector, modyule|  # intentional typo for module
      sector_commands = modyule::COMMANDS
      sector_commands.keys.map { |cmd| "#{sector}.#{cmd}" }
    end
    cmds.flatten + EXTRA_COMMANDS
  end
end
