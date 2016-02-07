class AlumniClient
  include Cache

  def initialize
    @base_url = ENV.fetch('ALUMNI_BASE_URL', 'http://alumni.lewagon.org/api/v1')
  end

  def stories(options = {})
    limit = options.fetch(:limit, 1)
    excluded_ids = options.fetch(:excluded_ids, [])
    get("#{@base_url}/stories", { params: { limit: limit, excluded_ids: excluded_ids.join(',') }})["stories"]
  end

  def story(github_nickname)
    from_cache(:stories, github_nickname) do
      get "#{@base_url}/stories/#{github_nickname}"
    end
  end

  def alumni
    from_cache(:alumni) do
      get("#{@base_url}/alumni")["alumni"]
    end
  end

  def live_batch
    get("#{@base_url}/batches/live")["batch"]
  end

  def testimonials(locale)
    from_cache(:testimonials, locale) do
      get "#{@base_url}/testimonials?locale=#{locale}"
    end
  end

  def projects(list_name = nil)
    from_cache(:projects, list_name) do
      if list_name
        get("#{@base_url}/projects?list_name=#{list_name}")["projects"]
      else
        get("#{@base_url}/projects")["projects"]
      end
    end
  end

  def cities
    from_cache(:cities) do
      get("#{@base_url}/cities")["cities"]
    end
  end

  def city_slugs
    from_cache(:city_slugs) do
      get("#{@base_url}/cities/slugs")["slugs"]
    end
  end

  def city(slug)
    from_cache(:city, slug) do
      get("#{@base_url}/cities/#{slug}")["city"]
    end
  end

  def staff(city_slug)
    from_cache(:staff, city_slug) do
      get("#{@base_url}/staff?city=#{city_slug}")["staff"]
    end
  end

  def batch(id)
    from_cache(:batch, id) do
      Api::Batch.new get("#{@base_url}/batches/#{id}")["batch"]
    end
  end

  def statistics
    from_cache(:statistics) do
      get "#{@base_url}/statistics"
    end
  end

  private

  def get(url, params = {})
    JSON.parse RestClient::Request.execute({
      method: :get,
      url: url,
      user: 'lewagon',
      password: ENV['ALUMNI_WWW_SHARED_SECRET'],
      payload: {}
    })
  end
end
