class Position
  include Rails.application.routes.url_helpers
  include ProxyHelper

  class RecordNotFound < Exception; end

  attr_reader :title, :company_name, :company_url
  delegate :name, :avatar_url, :camp, to: :user
  delegate :city, to: :camp

  def initialize(hash)
    @title = hash['title']
    @company_name = hash['company_name']
    @company_url = hash['company_url']
    @github_nickname = hash['github_nickname']
  end

  def company_image(height = nil, width = nil, quality = 100)
    proxy_url_with_signature \
      host: Rails.configuration.action_mailer.default_url_options[:host],
      url: "https://raw.githubusercontent.com/lewagon/www-images/master/companies/#{company_name.parameterize}.png",
      height: height,
      width: width,
      quality: quality
  end

  def self.all
    (POSITIONS || YAML.load_file(Rails.root.join("data/positions.yml"))).map do |position|
      Position.new(position)
    end
  end

  private

  def user
    @user ||= Kitt::Client.query(
      Student::UserQuery,
      variables: { github_nickname: @github_nickname }
    ).data.user
  end
end
