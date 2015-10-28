class StoriesController < ApplicationController
  before_action :set_client
  def show
    @stories = @client.stories
    @story = @stories.find {|story| story["alumni"]["github_nickname"] == params[:user_name] } || @stories.first
  end

  private
  def set_client
    @client = AlumniClient.new
  end
end
