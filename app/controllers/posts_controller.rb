require "blog"

class PostsController < ApplicationController
  skip_before_action :switch_to_french_if_needed
  before_action :set_french

  def index
    @posts = Blog.new.all
  end

  def show
    @post = Blog.new.post(params[:slug])
    render_404 if @post.nil?
  end

  private

  def set_french
    I18n.locale = :fr
  end
end
