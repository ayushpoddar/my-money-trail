# frozen_string_literal: true

require 'tty-prompt'
require 'active_support'

class FormBuilder
  class NoChoiceError < StandardError; end;

  # Creates an instance
  # @param [Hash] values - All the initial values for the form fields
  # Example values: { name: "Kotak Bank", initial_balance: 50 }
  def initialize(values={})
    @values = values.with_indifferent_access
  end

  def collect(&block)
    @block_binding = block.binding
    instance_eval(&block)
    @values
  end

  # Get input from user
  # @param [String/Symbol] name - Name of the field
  # @param [Hash] options - Options to be used
  # Supported options:
  # - label: Text to be printed to get the input [optional]
  # - modify: Modifications to be performed in the user input. Defaults to :strip, :collapse
  # - All the other options supported by `ask method` of tty-prompt
  # - - Look up `tty_options` method for a list of supported options
  def input(name, options)
    question = (options[:label] || "Please enter the #{name.to_s.humanize}") + ":"

    input_modify_opts = options.fetch(:modify, [:strip, :collapse])

    options = tty_options(name, options)

    @values[name] = prompt.ask(question, **options) do |q|
      q.modify *input_modify_opts
    end
  end

  # Get choice from user
  # @param [String/Symbol] name - Name of the field
  # @param [Hash] options - Options to be used
  # Supported options:
  # - label: Text to be printed to get the input [optional]
  # - choices: Array of hash. Each hash should have the form { name: , value: } [Mandatory]
  # - All the other options supported by `select` method of tty-prompt
  # - - Look up `tty_options` method for a list of supported options
  def choice(name, options)
    question = (options[:label] || "Please select the #{name.to_s.humanize}")

    choices = options[:choices]
    raise NoChoiceError, "No choices given" unless choices.is_a?(Array) && choices.length > 0

    options = tty_options(name, options)

    @values[name] = prompt.select(question, choices, **options)
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

  def _block_self_
    return nil if @block_binding.nil?
    @_block_self_ ||= @block_binding.eval("self")
  end

  def method_missing(meth, *args, &blk)
    return super if _block_self_.nil?
    return super unless _block_self_.respond_to?(meth, true)
    
    _block_self_.send meth, *args, &blk
  end

  def respond_to_missing?(meth, include_all)
    return super if _block_self_.nil?

    super || _block_self_.respond_to?(meth, true)
  end
end
