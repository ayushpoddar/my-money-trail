# frozen_string_literal: true

require "optparse"

module CliParser
  def self.call
    options = { env: "development" }

    OptionParser.new do |opts|
      opts.banner = "Usage: bin/run [options]"

      opts.on("-p", "--production", "Run in production mode") do
        options[:env] = "production"
      end
    end.parse!
    options
  end
end
