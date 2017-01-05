require "blog"

class PostsController < ApplicationController
  before_action :hide_drift

  def index
    @posts = Blog.new.all
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
