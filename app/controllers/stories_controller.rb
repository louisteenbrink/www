class StoriesController < ApplicationController
  def show
    @story = @client.story(params[:id])
    session[:story_ids] = [] if session[:story_ids].nil?
    session[:story_ids] << @story['id']
    session[:story_ids].uniq!

    @stories = @client.random_stories(limit: 3, excluded_ids: session[:story_ids])
  end
end
