module Cache
  def from_cache(*args, &block)
    expire = default_expire
    if args.last.is_a?(Hash)
      options = args.pop
      expire = options.fetch(:expire, expire)
    end
    the_key = key(*args)
    if (value = redis.get(the_key)).nil?
      value = yield(self)
      redis.set(the_key, Marshal.dump(value))
      redis.expire(the_key, expire)
      value
    else
      Marshal.load(value)
    end
  end

  def del_all
    redis.del "#{self.class.to_s.underscore}:*"
  end

  private

  def key(*args)
    "#{self.class.to_s.underscore}:#{args.join(":")}"
  end

  def redis
    $redis
  end

  def default_expire
    1.week
  end
end
