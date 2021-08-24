ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __dir__)
require "bundler/setup" # Set up gems listed in the Gemfile.


require "zeitwerk"

loader = Zeitwerk::Loader.new
loader.push_dir "#{__dir__}/models"
loader.setup


require "active_record"
require "yaml"

def run
  db_config = YAML::load(File.open("config/database.yml"))
  ActiveRecord::Base.establish_connection(db_config)
  yield
  ActiveRecord::Base.remove_connection
  puts "Bye"
end
