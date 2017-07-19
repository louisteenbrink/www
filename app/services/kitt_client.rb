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


  # def cities
  #   from_cache(:cities) do
  #     get("#{@base_url}/cities")["cities"]
  #   end
  # end

  # def city_groups
  #   from_cache(:city_groups) do
  #     get("#{@base_url}/city_groups")["groups"]
  #   end
  # end

  # def city_slugs
  #   from_cache(:city_slugs) do
  #     get("#{@base_url}/cities/slugs")["slugs"]
  #   end
  # end

  # def city(slug_or_id)
  #   from_cache(:city, slug_or_id) do
  #     Api::City.new(get("#{@base_url}/cities/#{slug_or_id}")["city"])
  #   end
  # end

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
