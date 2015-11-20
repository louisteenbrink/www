class StoriesController < ApplicationController
  def show
    @story = @client.story(params[:github_nickname])
    session[:story_ids] = [] if session[:story_ids].nil?
    session[:story_ids] << @story['id']
    session[:story_ids].uniq!

    @stories = @client.stories(limit: 3, excluded_ids: session[:story_ids])
  end
end
