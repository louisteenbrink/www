class AlumniClient
  include Cache

  def initialize
    @base_url = ENV.fetch('ALUMNI_BASE_URL', 'http://alumni.lewagon.org/api/v1')
  end

  def stories()
    from_cache(:stories) do
      get("#{@base_url}/stories")["stories"]
    end
  end

  def random_stories(options = {})
    limit = options.fetch(:limit, 1)
    excluded_ids = options.fetch(:excluded_ids, [])
    from_cache("random_stories:#{options.values.join(":")}", expire: 1.hour) do
      get("#{@base_url}/stories/sample", { params: { limit: limit, excluded_ids: excluded_ids.join(',') }})["stories"]
    end
  end

  def story(slug)
    from_cache(:stories, slug) do
      get "#{@base_url}/stories/#{slug}"
    end
  end

  def alumni
    from_cache(:alumni) do
      get("#{@base_url}/alumni")["alumni"]
    end
  end

  # TODO: put back in a yaml in www.
  def positions
    from_cache(:positions) do
      get("#{@base_url}/positions")["positions"]
    end
  end

  def staff(city_slug)
    from_cache(:staff, city_slug) do
      get("#{@base_url}/staff", params: { city: city_slug })["staff"]
    end
  end

  def statistics
    from_cache(:statistics) do
      get "#{@base_url}/statistics"
    end
  end

  def completed
    from_cache(:completed) do
      get("#{@base_url}/batches/completed")["batches"].map { |json| Api::Batch.new(json) }
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
