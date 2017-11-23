require 'rubygems'
require 'rake'
require 'yaml'
require 'time'

namespace :post do
  desc "Create a new post file. Usage: `DATE=2017-11-01 rails posts:create`"
  task create: :environment do


    puts "Title of the new post?"
    print "> "
    title = STDIN.gets.chomp
    slug = title.parameterize

    date = Time.now.strftime('%Y-%m-%d')
    puts "Date ? (#{date}) "
    new_date = STDIN.gets.chomp
    if new_date.present?
      if new_date =~ /\d{4}\-[01]\d\-[0123]\d/
        date = new_date
      else
        abort("The DATE must follow the YYYY-MM-DD format!")
      end
    end

    puts "Is this a video? (no)"
    video = STDIN.gets.chomp =~ /y/

    filename = File.join('posts', "#{date}-#{slug}.md")
    if File.exist?(filename)
      abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
    end

    puts "Creating new post: #{filename}"
    open(filename, 'w') do |post|
      post.puts "---"
      post.puts "layout: #{video ? 'video' : 'post'}"
      post.puts "title: \"#{title}\""
      post.puts "youtube_slug: TODO" if video
      post.puts "author: TODO"
      post.puts "labels:"
      post.puts "  - TODO"
      post.puts "thumbnail: TODO"
      post.puts "description: |"
      post.puts "  TODO"
      post.puts "---"
    end
  end
end # task :post
