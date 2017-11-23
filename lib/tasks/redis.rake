namespace :redis do
  namespace :cache do
    task clear: :environment do
      count = (Rails.cache.clear || 0)
      puts "Redis cache cleared. #{count || 0} keys deleted."
    end
  end
end
