class Testimonial
  DEFAULT_ROUTE = "home"

  class RecordNotFound < Exception; end

  PROPERTIES = %w(first_name last_name batch_slug project_slug publication_date job_before job_after new_company origin content_html linkedin_url)
  PROPERTIES.each do |prop|
    attr_reader prop.to_sym
  end
  attr_reader :github_nickname

  def initialize(github_nickname, hash)
    @hash = hash
    @github_nickname = github_nickname
    PROPERTIES.each do |prop|
      instance_variable_set :"@#{prop}", hash[prop]
    end
  end

  def city
    KittClient.new.city(@hash['city_slug'])
  rescue RestClient::ResourceNotFound
    nil
  end

  def project
    KittClient.new.products([@project_slug]).first
  end

  def batch_thumbnail
    KittClient.new.batch(@batch_slug)
  end

  def picture_url
    "https://raw.githubusercontent.com/lewagon/www-images/master/testimonials/#{@hash['picture']}"
  end

  def self.where(options = {})
    route = options.fetch(:route).to_s
    routes_testimonials = (TESTIMONIALS || YAML.load_file(Rails.root.join("data/testimonials.yml")))['routes']
    route_testimonials = routes_testimonials[route]
    if route_testimonials
      routes_testimonials[route].map { |github_nickname| find(github_nickname) }
    else
      []
    end
  end

  def self.find(github_nickname)
    testimonials = (TESTIMONIALS || YAML.load_file(Rails.root.join("data/testimonials.yml")))['testimonials']
    testimonial = testimonials[github_nickname]
    if testimonial
      Testimonial.new(github_nickname, testimonial)
    else
      fail RecordNotFound, "Couldn't find Testimonial with 'github_nickname'='#{github_nickname}'"
    end
  end
end
