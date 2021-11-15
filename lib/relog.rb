# frozen_string_literal: true

# Wrapper around the logger class
module Relog
  extend self

  def with_logging
    raise ArgumentError, "Providing a block is mandatory" unless block_given?

    @logger = Logger.new("log/development.log")
    @logger.info("STARTING APPLICATION IN #{Setup.env} ENVIRONMENT")
    yield(@logger)
    @logger.close
  end
end
