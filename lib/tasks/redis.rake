namespace :redis do
  namespace :cache do
    task clear: :environment do
      count = (Rails.cache.clear || 0)
      count += $redis.keys("kitt/client*").each { |key| $redis.del key }.size
      puts "Redis cache cleared. #{count || 0} keys deleted."
    end
  end
end
