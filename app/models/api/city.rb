class Api::City < Api::Record
  def self.find(slug)
    # TODO get info from cache or Api
    city = self.new
    city.extend(CityRepresenter)
    city.get(uri: "http://localhost:5000/api/v1/cities/#{slug}", as: "application/json")
  end
end
