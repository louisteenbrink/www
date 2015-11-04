class StoriesController < ApplicationController
  before_action :set_client

  def show
    @story = @client.story(params[:user_name])
    session[:story_ids] = [] if session[:story_ids].nil?
    session[:story_ids] << @story['id']
    session[:story_ids].uniq!

    @stories = @client.stories(limit: 3, excluded_ids: session[:story_ids])
  end

  private
  def set_client
    @client = AlumniClient.new
  end
end
