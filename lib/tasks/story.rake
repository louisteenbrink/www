namespace :story do
  # TODO remove after running
  task to_md: :environment do
    client = AlumniClient.new
    client.stories.each do |story|
      md = "---
layout: story
title:
  en: #{story['title']['en']}
  fr: #{story['title']['fr']}
alumnus_gh_nickname: #{story['alumni']['github_nickname']}
date: #{story["created_at"]}
cover_picture: #{story['picture']}
company_slug: #{story['company']['slug']}
---

#{story['description']['en']}


#{story['description']['fr']}"
    filename = "#{Date.parse(story['created_at'])}-#{story['slug']}.md"
    filepath = "#{File.expand_path File.dirname(__FILE__)}/../../stories/#{filename}"
    File.open(filepath, 'w') { |file| file.write(md) }
    end
  end
end
