class Company
  LOGO_FOLDER = "https://raw.githubusercontent.com/lewagon/www-images/master/companies"
  include Rails.application.routes.url_helpers
  include ProxyHelper

  attr_reader :slug, :name, :url

  def initialize(slug, attr)
    @slug = slug
    @name = attr['name']
    @url = attr['url']
  end

  def logo(height = nil, width = nil, quality = 100)
    proxy_url_with_signature \
      host: Rails.configuration.action_mailer.default_url_options[:host],
      url: "#{LOGO_FOLDER}/#{name.parameterize}.png",
      height: height,
      width: width,
      quality: quality
  end

  def self.all
    companies = (COMPANIES || YAML.load_file(Rails.root.join("data/companies.yml")))
    companies.map do |slug, attr|
      Company.new(slug, attr)
    end
  end

  def self.find(slug)
    all.find { |company| company.slug == slug }
  end
end
