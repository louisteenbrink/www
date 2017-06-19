class KittClient
  include Cache

  def initialize
    @base_url = ENV.fetch('KITT_BASE_URL', 'https://kitt.lewagon.com/api/v1')
  end

  def products(camp_slug = nil)
    if camp_slug
      url = "#{@base_url}/camps/#{camp_slug}/products"
    else
      url = "#{@base_url}/products"
    end
    get(url)["products"]
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
