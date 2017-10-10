class PostsController < ApplicationController
  before_action :hide_drift

  def index
    if request.format.html? || params[:post_page]
      posts = (Post.all + Story.all).sort_by { |p| p.date }.reverse
      @posts = Kaminari.paginate_array(posts.select(&:post?)).page(params[:post_page]).per(3)
      @videos = posts.select(&:video?)
      @stories = posts.select(&:story?)
    end

    if request.format.html?
      @statistics = @client.statistics
    end
  end

  def rss
    @posts = (Post.all + Story.all).sort_by { |p| p.date }.reverse
    render layout: false
  end

  def show
    @post = Post.find(params[:slug])
    posts = Post.all
    @videos = (posts.select(&:video?) - [ @post ]).sample(2)
    @posts = (posts.select(&:post?) - [ @post ]).sample(3)
    render_404 if @post.nil?
  end

  def videos
    posts = Post.all
    @videos = posts.select(&:video?)
    if params[:category].present?
      @videos = @videos.select { |post| post.labels.include? params[:category] }
    end
    @videos = Kaminari.paginate_array(@videos).page(params[:post_page]).per(6)
  end

  def all
    posts = (Post.all + Story.all).sort_by { |p| p.date }.reverse
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
