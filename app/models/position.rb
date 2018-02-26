class Position
  attr_reader :title, :linkedin, :github_nickname
  delegate :name, :official_avatar_url, :camp, to: :user
  delegate :city, to: :camp

  def initialize(github_nickname, hash)
    @github_nickname = github_nickname
    @title = hash['title']
    @linkedin = hash['linkedin']
    @company_slug = hash['company_slug']
  end

  def company
    @company ||= Company.find(@company_slug)
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
