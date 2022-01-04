# frozen_string_literal: true

require "yaml"

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

  def environments
    VALID_ENVIRONMENTS
  end

  def env
    @env
  end

  def db_config(environment=nil)
    environment ||= @env
    YAML.load_file("config/database.yml").fetch(environment)
  end
end
