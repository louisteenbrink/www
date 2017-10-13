class AlumniClient
  include Cache

  def initialize
    @base_url = ENV.fetch('ALUMNI_BASE_URL', 'http://alumni.lewagon.org/api/v1')
  end

  def statistics
    from_cache(:statistics) do
      get "#{@base_url}/statistics"
    end
  end

  private

  def get(url, headers = {})
    JSON.parse RestClient::Request.execute({
      method: :get,
      url: url,
      user: 'lewagon',
      password: ENV['ALUMNI_WWW_SHARED_SECRET'],
      headers: headers
    })
  end
end
