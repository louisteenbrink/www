SitemapGenerator::Sitemap.default_host = 'http://www.lewagon.com'

SitemapGenerator::Sitemap.create do
  add 'fr', changefreq: 'daily', priority: 0.9

  STATIC_ROUTES.each do |_, locale_paths|
    locale_paths.each do |_, page|
      add page
    end
  end
  Static::CITIES.keys.each do |slug|
    add slug
    add "fr/#{slug}"
  end

  add "alumni"
  add "fr/alumni"

  add "blog"
  add "faq"
  add "fr/faq"
  add "stack"
  add "fr/stack"

  client = AlumniClient.new
  client.stories.each do |story|
    github_nickname = story["alumni"]["github_nickname"]
    add "stories/#{github_nickname}"
    add "fr/stories/#{github_nickname}"
  end
end
