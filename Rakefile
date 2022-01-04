# Rakefile
require "bundler"
Bundler.require

require "active_record"
require "json"

require_relative "lib/setup"

namespace :db do
  def within_all_environments
    Setup.environments.each do |env|
      db_config = Setup.db_config(env)
      yield(db_config)
    end
  end

  def within_dev_environment
    db_config = Setup.db_config("development")
    yield(db_config)
  end

  desc "Create the database"
  task :create do
    within_all_environments do |db_config|
      ActiveRecord::Base.establish_connection(db_config)
      puts "Database created"
    end
  end

  desc "Migrate the database"
  task :migrate => :create do
    within_all_environments do |db_config|
      ActiveRecord::Base.establish_connection(db_config)
      ActiveRecord::MigrationContext.new("db/migrate/", ActiveRecord::SchemaMigration).migrate
      puts "Database migrated"
    end
  end

  desc "Drop the database"
  task :drop do
    within_all_environments do |db_config|
      File.delete(db_config["database"]) if File.exist?(db_config["database"])
      puts "Database deleted"
    end
  end

  desc "Reset the database"
  task reset: [:drop, :create, :migrate]

  desc "Create a db/schema.rb file"
  task :schema => :migrate do
    within_dev_environment do |db_config|
      ActiveRecord::Base.establish_connection(db_config)
      require "active_record/schema_dumper"
      filename = "db/schema.rb"
      File.open(filename, "w:utf-8") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
      puts 'Schema dumped'
    end
  end

  desc 'Populate the database'
  task :seed => :migrate do
    within_dev_environment do |db_config|
      ActiveRecord::Base.establish_connection(db_config)
      load 'db/seed.rb' if File.exist?('db/seed.rb')
    end
  end
end

namespace :g do
  desc "Generate migration"
  task :migration do
    name = ARGV[1] || raise("Specify name: rake g:migration your_migration")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, "w") do |file|
      file.write <<~EOF
        # frozen_string_literal: true

        class #{migration_class} < ActiveRecord::Migration[6.0]
          def change
          end
        end
      EOF
    end

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end
