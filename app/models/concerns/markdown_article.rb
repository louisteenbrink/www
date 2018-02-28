require "deep_symbolize"

module MarkdownArticle
  extend ActiveSupport::Concern

  included do
    def initialize(file)
      @file = file
    end
  end

  class_methods do
    def all
      files.reverse.map do |file|
        self.new(file)
      end
    end

    def random(options = { limit: 1, excluded_slugs: [] })
      stories = files
      if options[:excluded_slugs].is_a? Array
        stories = files.reject { |file| options[:excluded_slugs].include?(file) }
      end
      files.sample(options[:limit]).map { |file| self.new(file) }
    end

    def find(slug)
      slug.gsub!(".html", '')
      files.each do |file|
        return self.new(file) if file.include?(slug)
      end
      nil
    end

    def files
      Dir[Rails.root.join("#{self.name.underscore.pluralize}/*.md")].sort
    end
  end

  JEKYLL_HEADER_PATTERN = /---(.*)---/m
  JEKYLL_EXCERPT_SEPARATOR = /===/
  BLOG_IMAGE_PATH_PATTERN = /blog_image_path ([^\)"']*)/

  def excerpt
    @excerpt ||= markdown.render(article_content.split(JEKYLL_EXCERPT_SEPARATOR).first)
  end

  def excerpt?
    article_content.include? "==="
  end

  def content
    @content ||= markdown.render(article_content.gsub("===", ""))
  end

  DEFAULT_READING_TIME_IN_MINUTES = 2
  AVERAGE_WORD_PER_MINUTES = 200

  # Number of minutes neede to read post.
  def read_time
    if content.length > 0
      words_number = content.split(" ").count
      reading_time = (words_number / AVERAGE_WORD_PER_MINUTES).ceil
      [reading_time, DEFAULT_READING_TIME_IN_MINUTES].max
    else
      DEFAULT_READING_TIME_IN_MINUTES
    end
  end

  def metadata
    @metadata ||= (
      yaml_content = JEKYLL_HEADER_PATTERN.match(file_content).captures[0]
      metadata = yaml_content ? YAML.load(yaml_content) : {}
      metadata.extend DeepSymbolizable
      metadata.deep_symbolize { |key| key }
    )
  end

  class UnknownAuthorError < Exception; end

  def author
    the_author = Static::AUTHORS[metadata[:author].to_sym]
    if the_author.blank?
      fail UnknownAuthorError, "'#{metadata[:author]}' is not a valid author. You can use one of these: #{Static::AUTHORS.keys.sort.to_sentence}"
    else
      return the_author
    end
  end

  def locale_icon
    "icon_flag_#{metadata[:locale]}"
  end

  def method_missing(m, *args)
    metadata[m]
  end

  private

  def file_content
    @file_content ||= File.read(@file)
  end

  def article_content
    @article_content ||= (
      content = file_content.gsub(JEKYLL_HEADER_PATTERN, '')
      content = content.gsub(BLOG_IMAGE_PATH_PATTERN) do
        "https://raw.githubusercontent.com/lewagon/www-images/master/blog/posts/#{$1}"
      end
    )
  end

  def markdown
    @markdown ||= Redcarpet::Markdown.new(PygmentizeHTML, fenced_code_blocks: true)
  end

  class PygmentizeHTML < Redcarpet::Render::HTML
    def initialize(extensions = {})
      super extensions.merge(link_attributes: { target: "_blank" })
    end

    def block_code(code, language)
      language = :javascript if language == "json"
      language = :bash unless language
      require 'pygmentize'
      Pygmentize.process(code, language)
    end
  end
end
