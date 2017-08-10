class Api::Batch < Api::Record
  def self.find(slug)
    # TODO get info from cache or Api
    batch = self.new
    batch.extend(BatchRepresenter)
    batch.get(uri: "http://localhost:5000/api/v1/camps/#{slug}", as: "application/json")
  end

  def city
    url = links['city'].href
    city = Api::City.new
    city.extend(CityRepresenter)
    city.get(uri: url, as: "application/json")
  end

  def students
    url = links['students']
    students = Api::User.all(url)
  end
end
