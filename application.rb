ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __dir__)
require "bundler/setup" # Set up gems listed in the Gemfile.


module MyMoneyTrail
  require "zeitwerk"

  @loader = Zeitwerk::Loader.new
  @loader.push_dir "#{__dir__}/lib/models"
  @loader.enable_reloading
  @loader.setup

  def reload!
    @loader.reload
  end


  require "active_record"
  require "yaml"

  def run
    logger = Logger.new(STDOUT)
    # logger.level = Logger::WARN

    db_config = YAML::load(File.open("config/database.yml"))
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Base.logger = logger

    yield

    ActiveRecord::Base.remove_connection
    logger.info("Bye")
    logger.close
  end


  module_function :run, :reload!
end
