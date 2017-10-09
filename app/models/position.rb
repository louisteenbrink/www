class Position
  include Rails.application.routes.url_helpers
  include ProxyHelper

  class RecordNotFound < Exception; end

  attr_reader :title, :company_name, :company_url, :github_nickname
  delegate :name, :avatar_url, :camp, to: :user
  delegate :city, to: :camp

  def initialize(github_nickname, hash)
    @github_nickname = github_nickname
    @title = hash['title']
    @company_name = hash['company_name']
    @company_url = hash['company_url']
  end

  def company_logo(height = nil, width = nil, quality = 100)
    proxy_url_with_signature \
      host: Rails.configuration.action_mailer.default_url_options[:host],
      url: "https://raw.githubusercontent.com/lewagon/www-images/master/companies/#{company_name.parameterize}.png",
      height: height,
      width: width,
      quality: quality
  end

  def self.all
    positions = (POSITIONS || YAML.load_file(Rails.root.join("data/positions.yml"))).with_indifferent_access
    positions[:default].map do |github_nickname|
      Position.new(github_nickname, positions[:positions][github_nickname])
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
