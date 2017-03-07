class StudentsController < ApplicationController
  respond_to :html, :js

  def index
    if request.format.html? || params[:testimonial_page]
      @testimonials = @client.testimonials(locale.to_s)
      @testimonials = Kaminari.paginate_array(@testimonials).page(params[:testimonial_page]).per(6)
    end

    if request.format.html? || params[:story_page]
      @stories = @client.stories
      @stories =  Kaminari.paginate_array(@stories).page(params[:story_page]).per(4)
    end

    if request.format.html?
      @projects = @client.projects("alumni_projects")
      @statistics = @client.statistics
      @reviews = ReviewsCounter.new.review_count
    end
  end
end
