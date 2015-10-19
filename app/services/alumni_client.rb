class AlumniClient

  def initialize
    @base_url = "http://alumni.lewagon.org/api/v1"
  end

  def stories
    JSON.parse(RestClient.get("#{@base_url}/stories"))["stories"]
  end

  def alumni
    JSON.parse(RestClient.get("#{@base_url}/alumni"))["alumni"]
  end

  def projects(slugs=false)
    if slugs
      slugs = slugs.join(',')
      JSON.parse(RestClient.get("#{@base_url}/projects?slug=#{slugs}"))["projects"]
    else
      JSON.parse(RestClient.get("#{@base_url}/projects"))["projects"]
    end
  end

  def cities
    JSON.parse(RestClient.get("#{@base_url}/cities?active=true"))["cities"]
  end

  def city(slug)
    JSON.parse(RestClient.get("#{@base_url}/cities/#{slug}"))["city"]
  end

  def staff(city_slug)
    JSON.parse(RestClient.get("#{@base_url}/staff?city=#{city_slug}"))["staff"]
  end

  def batch(id)
    Api::Batch.new JSON.parse(RestClient.get("#{@base_url}/batches/#{id}"))["batch"]
  end
end
