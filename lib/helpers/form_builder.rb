# frozen_string_literal: true

require 'tty-prompt'
require 'active_support'

class FormBuilder
  def collect(&block)
    prompt.collect(&block)
  end

  def input(name, required: false, label: nil)
    question = label || "Please enter the #{name.to_s.humanize}"
    key(name).ask(question, required: required)
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
