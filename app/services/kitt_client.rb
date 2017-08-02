class KittClient
  include Cache

  def initialize
    @base_url = ENV.fetch('KITT_BASE_URL', 'https://kitt.lewagon.com/api/v1')
  end

  def products(slugs = [])
    if slugs.empty?
      url = "#{@base_url}/products"
    else
      slugs_query = slugs.to_query('slugs')
      url = "#{@base_url}/products?#{slugs_query}"
    end
    from_cache(:projects, slugs.join(',')) do
      get(url)["products"]
    end
  end

  def batch(slug)
    Api::Batch.new get("#{@base_url}/camps/#{slug}")
  end

  def batches(filter = "all")
    if filter == 'completed'
      get("#{@base_url}/camps/completed")["batches"].map { |json| Api::Batch.new(json) }
    end
  end

  def city_groups
    Static::CITIES.map do |group|
      slugs = group[:cities]
      #TODO how to invalidate this cache?
      group[:cities] = from_cache(:cities, slugs.join(',')) do
        get("#{@base_url}/cities?#{slugs.to_query('slugs')}")["cities"]
      end
      group
    end
  end

  def city_slugs
    #TODO how to invalidate this cache?
    from_cache(:city_slugs) do
      get("#{@base_url}/cities/slugs")["slugs"]
    end
  end

  def city(slug)
    #TODO how to invalidate this cache?
    from_cache(:city, slug) do
      Api::City.new(get("#{@base_url}/cities/#{slug}"))
    end
  end

  def teachers(city_slug)
    #TODO how to invalidate this cache?
    from_cache(:teachers, city_slug) do
      get("#{@base_url}/cities/#{city_slug}/teachers")["team"]
    end
  end

  private

  def get(url, headers = {})
    JSON.parse RestClient::Request.execute({
      method: :get,
      url: url,
      user: 'lewagon',
      password: ENV['KITT_WWW_SHARED_SECRET'],
      headers: headers
    })
  end
end
