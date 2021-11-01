# frozen_string_literal: true

require 'tty-prompt'
require 'active_support'

class FormBuilder
  # Creates an instance
  # @param [Hash] values - All the initial values for the form fields
  # Example values: { name: "Kotak Bank", initial_balance: 50 }
  def initialize(values={})
    @values = values.with_indifferent_access
  end

  def collect(&block)
    instance_eval(&block)
    @values
  end

  # Get input from user
  # @param [String] name - Name of the field
  # @param [Hash] options - Options to be used
  # Supported options:
  # - label: Text to be printed to get the input
  # - modify: Modifications to be performed in the user input. Defaults to :strip, :collapse
  # - All the other options supported by `ask method` of tty-prompt
  def input(name, options)
    question = (options[:label] || "Please enter the #{name.to_s.humanize}") + ":"

    input_modify_opts = options.fetch(:modify, [:strip, :collapse])

    options = tty_options(name, options)

    @values[name] = prompt.ask(question, **options) do |q|
      q.modify *input_modify_opts
    end
  end

  private

  def prompt
    @prompt ||= TTY::Prompt.new
  end

  def tty_options(name, options)
    options = options.slice(:convert, :default, :required, :value)

    return options if options.has_key?(:value)
    return options if @values[name].nil?

    return options.merge(value: @values[name])
  end
end
