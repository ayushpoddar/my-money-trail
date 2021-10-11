# frozen_string_literal: true

require 'tty-prompt'
require 'active_support'

class FormBuilder
  # Creates an instance
  # @param [Hash] values - All the initial values for the form fields
  # Example values: { name: "Kotak Bank", initial_balance: 50 }
  def initialize(values)
    @values = values
  end

  def collect(&block)
    prompt.collect(&block)
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

    options = options.except(:label, :modify)
    options[:value] ||= @values[name.to_sym].to_s
    key(name).ask(question, **options) do |q|
      q.modify *input_modify_opts
    end
  end

  private

  def prompt
    @form_prompt ||= begin
      prompt = TTY::Prompt.new

      class << prompt
        attr_accessor :form_builder

        def answers_collector
          @answers_collector ||= begin
            collector = TTY::Prompt::AnswersCollector.new(self)
            class << collector
              def input(...)
                @prompt.form_builder.input(...)
              end
            end
            collector
          end
        end

        def collect(&block)
          answers_collector.call(&block)
        end
      end

      prompt.form_builder = self
      prompt
    end
  end

  def key(*args)
    prompt_collector.key(*args)
  end

  def prompt_collector
    prompt.answers_collector
  end
end
