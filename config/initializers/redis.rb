$redis = Redis.new

url = ENV["REDISCLOUD_URL"]

if url && defined?(Sidekiq)
  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end
  $redis = Redis.new(:url => url)
end

class Redis
  def cache(key, expire = nil, recalculate = false)
    if (value = get(key)).nil? || recalculate
      value = yield(self)
      set(key, Marshal.dump(value))
      expire(key, expire) if expire
      value
    else
      Marshal.load(value)
    end
  end
end
