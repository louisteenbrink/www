require "blog"

class PostsController < ApplicationController
  def index
    @posts = Blog.new.all
  end

  def show
    @post = Blog.new.post(params[:slug])
    render_404 if @post.nil?
  end
end
