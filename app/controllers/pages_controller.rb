# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  before_action :switch_to_french_if_needed, only: :home
  before_action :set_top_bar, only: :home
  after_action :mark_as_tracked, only: :thanks

  def show
    render params[:template]
  end

  def live
    respond_to do |format|
      format.html do
        if @live
          if @live.demoday?
            redirect_to demoday_path(@live.batch_slug)
          else
            @city = Kitt::Client.query(City::Query, variables: { slug: @live.city_slug }).data.city
          end
        end
      end
      format.js
    end
  end

  def home
    if locale == :"pt-BR"
      session[:city] = 'sao-paulo'
    end

    @statistics = Kitt::Client.query(Statistics::Query).data.statistics

    if request.format.html? || params[:testimonial_page]
      @testimonials = Testimonial.where(route: Testimonial::DEFAULT_ROUTE)
      @testimonials = Kaminari.paginate_array(@testimonials).page(params[:testimonial_page]).per(6)
    end

    @stories = Story.all
    if locale == :fr
      @stories = @stories.select { |m| m.locale == "fr" }
      @stories = Kaminari.paginate_array(@stories).page(params[:story_page]).per(2)
    else
      @stories = @stories.select { |m| m.locale == "en" }
      @stories = Kaminari.paginate_array(@stories).page(params[:story_page]).per(2)
    end
  end

  def thanks
    if session[:apply_id].blank?
      redirect_to root_path
    else
      @apply = Apply.find(session[:apply_id])
      @city = @apply.city
      @batch = @apply.batch
      meetup = MeetupApiClient.new(@apply.city.meetup_id).meetup
      @meetup_url = meetup['link'] if meetup
    end
  end

  def employers
    @positions = Position.all
    @employer = EmployerProspect.new
  end

  def stack
  end

  def about
    @statistics = Kitt::Client.query(Statistics::Query).data.statistics
  end

  def robots
    respond_to :text
    expires_in 6.hours, public: true
  end

  def program
    @statistics = Kitt::Client.query(Statistics::Query).data.statistics
    @prospect = Prospect.new
  end

  def linkedin
    render json: params.to_json
  end

  def react
    return render_404
  end

  def vae
  end

  def cgv
  end

  private

  def set_top_bar
    # if I18n.locale == :fr
    #   @top_bar_message = I18n.t('.top_bar_react_message')
    #   @top_bar_cta = I18n.t('.top_bar_react_cta')
    #   @top_bar_url = react_path
    # end
  end

  def mark_as_tracked
    @apply.update tracked: true if @apply
  end

  def switch_to_french_if_needed
    if (request.env["HTTP_ACCEPT_LANGUAGE"] || "").split(",").first =~ /^fr/ && I18n.locale != :fr && !session[:fr_already_forced]
      session[:fr_already_forced] = true
      redirect_to '/fr'
    end
  end
end
