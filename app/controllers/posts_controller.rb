require "blog"

class PostsController < ApplicationController
  before_action :hide_drift

  def index
    if request.format.html? || params[:post_page]
      posts = Blog.new.all
      @posts = posts.select { |post| post.layout.to_sym == :post }
      @posts_count = @posts.length
      @posts = Kaminari.paginate_array(@posts).page(params[:post_page]).per(9)
      @videos = posts.select { |post| post.layout.to_sym == :video }
      @videos_count = @videos.length
    end

    if request.format.html?
      @statistics = @client.statistics
    end
  end

  def rss
    @posts = Blog.new.all
  end

  def show
    @post = Blog.new.post(params[:slug])
    posts = Blog.new.all
    @videos = posts.select { |post| post.layout.to_sym == :video }
    render_404 if @post.nil?
  end

  def videos
    if request.format.html? || params[:post_page]
      posts = Blog.new.all
      @videos = posts.select { |post| post.layout.to_sym == :video }
      @workshop = @videos.select { |post| post.metadata[:labels].include? "workshop" }
      @talks = @videos.select { |post| post.metadata[:labels].include? "talks" }
      @videos = Kaminari.paginate_array(@videos).page(params[:post_page]).per(9)
    end
  end

  def all
    if request.format.html? || params[:post_page]
      posts = Blog.new.all
      @posts = posts.select { |post| post.layout.to_sym == :post }
      @posts = Kaminari.paginate_array(posts).page(params[:post_page]).per(9)
    end
  end

  private

  def hide_drift
    @hide_drift = true
  end
end
