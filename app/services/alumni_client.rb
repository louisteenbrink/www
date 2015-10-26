class AlumniClient
  include Cache

  def initialize
    @base_url = "http://alumni.lewagon.org/api/v1"
  end

  def stories
    from_cache(:stories) do
      JSON.parse(RestClient.get("#{@base_url}/stories"))["stories"]
    end
  end

  def alumni
    from_cache(:alumni) do
      JSON.parse(RestClient.get("#{@base_url}/alumni"))["alumni"]
    end
  end

  def testimonials(locale)
    from_cache(:testimonials, locale) do
      JSON.parse(RestClient.get("#{@base_url}/testimonials?locale=#{locale}"))
    end
  end

  def projects(list_name = nil)
    from_cache(:projects, list_name) do
      if list_name
        JSON.parse(RestClient.get("#{@base_url}/projects?list_name=#{list_name}"))["projects"]
      else
        JSON.parse(RestClient.get("#{@base_url}/projects"))["projects"]
      end
    end
  end

  def cities
    from_cache(:cities) do
      JSON.parse(RestClient.get("#{@base_url}/cities"))["cities"]
    end
  end

  def city(slug)
    from_cache(:city, slug) do
      JSON.parse(RestClient.get("#{@base_url}/cities/#{slug}"))["city"]
    end
  end

  def staff(city_slug)
    from_cache(:staff, city_slug) do
      JSON.parse(RestClient.get("#{@base_url}/staff?city=#{city_slug}"))["staff"]
    end
  end

  def batch(id)
    from_cache(:batch, id) do
      Api::Batch.new JSON.parse(RestClient.get("#{@base_url}/batches/#{id}"))["batch"]
    end
  end
end
