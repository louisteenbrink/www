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

  def camp(camp_slug)
    url = "#{@base_url}/camps/#{camp_slug}"
    get(url)
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
