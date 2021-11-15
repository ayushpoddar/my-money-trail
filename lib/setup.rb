# frozen_string_literal: true

module Setup
  VALID_ENVIRONMENTS = %w(development production).freeze

  extend self

  # Environment
  def env=(env)
    raise SecurityError, "Environment cannot be modified" if @env
    raise ArgumentError, "Invalid environment provided" unless VALID_ENVIRONMENTS.include?(env)
    env ||= "development"

    m = Module.new do
      # Defines #development? #production?
      VALID_ENVIRONMENTS.each do |e|
        define_method "#{e}?" do
          self.to_s == e.to_s
        end
      end
    end
    @env = env.dup
    @env.extend m
    @env.freeze
  end

  def env
    @env
  end
end

