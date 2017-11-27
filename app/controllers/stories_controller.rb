class StoriesController < ApplicationController
  def show
    @story = Story.find(params[:id])
    return render_404 if @story.blank?

    session[:story_slug] = [] if session[:story_slug].nil?
    session[:story_slug] << @story.slug
    session[:story_slug].uniq!

    @stories = Story.random(limit: 2, excluded_slugs: session[:story_slugs])
  end
end
