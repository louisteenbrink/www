require "blog"

class PostsController < ApplicationController
  before_action :hide_drift

  def index
    if request.format.html? || params[:post_page]
      json_stories = @client.stories
      stories = json_stories.map { |story| AlumniStory.new(story) }
      articles = Blog.new.all
      posts = (articles + stories).sort_by { |p| p.date }.reverse
      @posts = posts.select(&:post?)
      @posts = Kaminari.paginate_array(@posts).page(params[:post_page]).per(3)
      @videos = posts.select(&:video?)
      @stories = @client.stories
    end

    if request.format.html?
      @statistics = @client.statistics
    end
  end

  def rss
    json_stories = @client.stories
    stories = json_stories.map { |story| AlumniStory.new(story) }
    articles = Blog.new.all
    @posts = (articles + stories).sort_by { |p| p.date }.reverse
    render layout: false
  end

  def show
    @post = Blog.new.post(params[:slug])
    posts = Blog.new.all
    @videos = (posts.select(&:video?) - [ @post ]).sample(2)
    @posts = (posts.select(&:post?) - [ @post ]).sample(3)
    render_404 if @post.nil?
  end

  def videos
    posts = Blog.new.all
    @videos = posts.select(&:video?)
    if params[:category].present?
      @videos = @videos.select { |post| post.labels.include? params[:category] }
    end
    @videos = Kaminari.paginate_array(@videos).page(params[:post_page]).per(6)
  end

  def all
    json_stories = @client.stories
    stories = json_stories.map { |story| AlumniStory.new(story) }
    articles = Blog.new.all
    posts = (articles + stories).sort_by { |p| p.date }.reverse

    @posts = posts.select(&:post?)
    if params[:category].present?
      @posts = @posts.select { |post| post.labels.include? params[:category] }
    end
    @posts = Kaminari.paginate_array(@posts).page(params[:post_page]).per(9)
  end

  private

  def hide_drift
    @hide_drift = true
  end
end
