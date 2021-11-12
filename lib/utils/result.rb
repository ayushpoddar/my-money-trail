# frozen_string_literal: true

# Examples
#
# InteractorA
#   .find_entity_a
#   .and_then { |entity_a| InteractorB.get_something(entity_a) }
#   .on_success { |something|  present something, with: Entities::Something }
#   .on(NotFoundError) { |error| error!(error, 404) }
#
# Contract.create(customer_id, contract_params)
#   .on_success { |new_contract| render new_contract, status: 200 }
#   .on(ValidationError) { |error| render :edit, status: 422 }
#   .on_failure { |error| render :whoops, status: 500 }

require_relative "errors"

module Result
  def self.included(klass)
    klass.prepend(Decorator)
  end

  module Decorator
    def call(...)
      result = super
      return result if result.is_a? Base

      Okay.new(result)
    rescue StandardError => e
      Error.new(e)
    end
  end

  class Base
    def initialize(value)
      @value = value
      @collected_data = {}
    end

    def on_success; self; end

    def on_failure; self; end

    def on(_); self; end

    def ok?; raise "Not implemented"; end

    alias :success? :ok?

    def error?
      !ok?
    end

    def save_value_as(key, default={})
      @collected_data[key] = default
      self
    end

    alias :failure? :error?
    alias :failed? :error?

    def and_then; self; end

    def or_else; self; end

    def to_s
      "#{self.class.name} Value => #{value}"
    end

    protected

    attr_reader :value
    attr_accessor :collected_data
  end

  class Okay < Base
    def ok?; true; end

    def on_success
      yield(value, collected_data)
      self
    end

    def and_then
      result = yield(value, collected_data)

      raise TypeError, "Block did not return Result::Base instance" unless result.is_a? Base
      result.collected_data = self.collected_data
      result
    end

    def save_value_as(key, _default=nil)
      @collected_data[key] = value
      self
    end

  end

  class Error < Base
    alias :error_object :value

    def initialize(...)
      super
      validate_error_object!
    end

    def ok?; false; end

    def on_failure
      return self if @error_handled

      yield(error_object, collected_data)
      @error_handled = true
      self
    end

    def on(error_class)
      return self unless error_object.is_a? error_class
      return self if @error_handled

      yield(error_object, collected_data)
      @error_handled = true
      self
    end

    def or_else
      result = yield(error_object, collected_data)
      raise TypeError, "Block did not return Result::Base instance" unless result.is_a? Base
      result.collected_data = self.collected_data
      result
    end

    private

    def validate_error_object!
      return true if error_object.class.module_parents.first.name == "Errors"
      raise TypeError, "Raised Error is not supported in the Utils/Errors module."
    end
  end
end

