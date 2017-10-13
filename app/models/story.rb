class Story
  include MarkdownArticle

  def post?
    true
  end

  def story?
    true
  end

  def slug
    @slug ||= (Pathname.new(@file).basename.to_s[/(.*)\.md/, 1])
  end

  def company
    @company ||= Company.find(metadata[:company_slug])
  end

  def alumnus
    @alumnus ||= Kitt::Client.query(
      Student::UserQuery,
      variables: { github_nickname: metadata[:alumnus_github_nickname] }
    ).data.user
  end

  def city
    return nil if city_slug.blank?
    @city ||= Kitt::Client.query(City::Query, variables: { slug: city_slug }).data.city
  end

  def labels
    %w(alumni story)
  end

  def author
    {
      fname: alumnus.first_name,
      lname: alumnus.last_name,
      picture: alumnus.avatar_url,
      batch: alumnus.camp.slug,
      city: alumnus.camp.city.name
    }
  end
end
