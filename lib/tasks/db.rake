require "uri"

namespace :db do
  desc "Dump AWS production DB and restore it locally."
  task import_from_aws: [ :environment, :create ] do
    c = Rails.configuration.database_configuration[Rails.env]
    Bundler.with_clean_env do
      puts "[1/4] Fetching DB password from Heroku"
      db = URI(`heroku config:get DATABASE_URL`)
      file = "tmp/rds.dump"

      puts "[2/4] Dumping DB"
      `PGPASSWORD=#{db.password} pg_dump -h #{db.host} -U #{db.user} -d #{db.path[1..-1]} -F c -b -v -f #{file}`

      puts "[3/4] Restoring dump on local database"
      `pg_restore --clean --verbose --no-acl --no-owner -h #{c["host"] || 'localhost'} -d #{c["database"]} #{file}`

      puts "[4/4] Removing local backup"
      `rm #{file}`
      puts "Done."
    end
  end
end
