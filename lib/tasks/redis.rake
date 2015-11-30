namespace :redis do
  namespace :cache do
    task clear: :environment do
      count = (Rails.cache.clear || 0) + (AlumniClient.new.del_all || 0)
      puts "Redis cache cleared. #{count || 0} keys deleted."
    end
  end
end
