namespace :redis do
  namespace :cache do
    task clear: :environment do
      count = Rails.cache.clear
      puts "Redis cache cleared. #{count || 0} keys deleted."
    end
  end
end
