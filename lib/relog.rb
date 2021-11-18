# frozen_string_literal: true

# Wrapper around the logger class
module Relog
  extend self

  def with_logging
    raise ArgumentError, "Providing a block is mandatory" unless block_given?

    create_logger
    @logger.info("STARTING APPLICATION IN #{Setup.env} ENVIRONMENT")
    yield(@logger)
    @logger.close
  end

  private

  def create_logger
    return if defined?(@logger)
    environment = Setup.env
    filename = "log/#{environment}.log"

    @logger = Logger.new(filename)
    if environment.development?
      stdout_logger = Logger.new(STDOUT)
      @logger.extend ActiveSupport::Logger.broadcast(stdout_logger)
    end
  end

end
