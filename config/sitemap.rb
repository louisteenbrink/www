SitemapGenerator::Sitemap.default_host = 'https://www.lewagon.com'

SitemapGenerator::Sitemap.create do
  add 'fr', changefreq: 'daily', priority: 0.9

  STATIC_ROUTES.each do |_, locale_paths|
    locale_paths.each do |_, page|
      add page, priority: 0.8
    end
  end

  add "alumni", priority: 0.8
  add "fr/alumni", priority: 0.8

  add "blog", priority: 0.8
  add "faq", priority: 0.8
  add "fr/faq", priority: 0.8
  add "stack", priority: 0.6
  add "fr/stack", priority: 0.6

  Story.all.each do |slug|
    add "stories/#{slug}", priority: 0.6
  end

  Post.all.each do |post|
    add "blog/#{post.slug}", priority: 0.6
  end
end
