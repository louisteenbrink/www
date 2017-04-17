require "blog"

class PostsController < ApplicationController
  before_action :hide_drift

  def index
    if request.format.html? || params[:post_page]
      @posts = Blog.new.all
      @posts =  Kaminari.paginate_array(@posts).page(params[:post_page]).per(9)
    end
  end

  def rss
    @posts = Blog.new.all
  end

  def show
    @post = Blog.new.post(params[:slug])
    render_404 if @post.nil?
  end

  private

  def hide_drift
    @hide_drift = true
  end
end
