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
  def projects
    JSON.parse(RestClient.get("#{@base_url}/projects?featured=true"))["projects"]
  end
  def cities
    JSON.parse(RestClient.get("#{@base_url}/cities?active=true"))["cities"]
  end

end
