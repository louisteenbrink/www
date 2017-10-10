SitemapGenerator::Sitemap.default_host = 'https://www.lewagon.com'

SitemapGenerator::Sitemap.create do
  add 'fr', changefreq: 'daily', priority: 0.9

  STATIC_ROUTES.each do |_, locale_paths|
    locale_paths.each do |_, page|
      add page, priority: 0.8
    end
  end

  AlumniClient.new.cities.map { |city_group| city_group["cities"] }.flatten.map { |city| city["slug"] }.each do |slug|
    add slug
    add "fr/#{slug}"
  end

  add "alumni", priority: 0.8
  add "fr/alumni", priority: 0.8

  add "blog", priority: 0.8
  add "faq", priority: 0.8
  add "fr/faq", priority: 0.8
  add "stack", priority: 0.6
  add "fr/stack", priority: 0.6

  client = AlumniClient.new
  client.stories.each do |story|
    github_nickname = story["alumni"]["github_nickname"]
    add "stories/#{github_nickname}", priority: 0.6
    add "fr/stories/#{github_nickname}", priority: 0.6
  end

  Post.all.each do |post|
    add "blog/#{post.slug}", priority: 0.6
  end
end
