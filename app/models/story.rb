class Story
  include MarkdownArticle

  def post?
    true
  end

  def story?
    true
  end

  def video?
    false
  end

  def slug
    @slug ||= (Pathname.new(@file).basename.to_s[/(.*)\.md/, 1])
  end

  def date
    @date ||= Date.parse(metadata[:date])
  end

  def company
    @company ||= (Company.find(metadata[:company_slug]) || Company.find('lewagon'))
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
      picture: alumnus.official_avatar_url,
      batch: alumnus.camp.slug,
      city: alumnus.camp.city.name
    }
  end

  def as_json(options = {})
    {
      slug: slug,
      thumbnail: thumbnail,
      title: title,
      description: description,
      company: {
        url: company.url,
        logo: company.logo
      },
      alumnus: {
        first_name: alumnus.first_name,
        official_avatar_url: alumnus.official_avatar_url,
        camp: {
          slug: alumnus.camp.slug
        },
        city: {
          name: alumnus.camp.city.name
        }
      }
    }
  end
end
