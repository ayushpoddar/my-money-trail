# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __dir__)
require 'bundler/setup' # Set up gems listed in the Gemfile.

module MyMoneyTrail # rubocop:disable Style/Documentation
  require 'zeitwerk'
  require 'active_record'
  require 'yaml'
  require_relative 'lib/commands'
  require_relative "lib/helpers/hash"

  @loader = Zeitwerk::Loader.new
  @loader.push_dir "#{__dir__}/lib/models"
  @loader.push_dir "#{__dir__}/lib/commands", namespace: Commands
  @loader.enable_reloading
  @loader.setup

  extend self

  def reload!
    @loader.reload
  end

  def run
    logger = Logger.new($stdout)
    # logger.level = Logger::WARN

    db_config = YAML.load_file('config/database.yml')
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Base.logger = logger

    yield

    ActiveRecord::Base.remove_connection
    logger.info('Bye')
    logger.close
  end
end
