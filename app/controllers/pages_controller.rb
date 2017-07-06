# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  before_action :switch_to_french_if_needed, only: :home
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
            @city = @client.city(@live.city_slug)
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
    home_projects_slugs = Static::PROJECTS[:home]
    @projects = KittClient.new.products(home_projects_slugs)

    @reviews = ReviewsCounter.new.review_count

    if request.format.html? || params[:testimonial_page]
      @testimonials = Testimonial.where(route: Testimonial::DEFAULT_ROUTE)
      @testimonials = Kaminari.paginate_array(@testimonials).page(params[:testimonial_page]).per(6)
    end
  end

  def thanks
    if session[:apply_id].blank?
      redirect_to root_path
    else
      @apply = Apply.find(session[:apply_id])
      @city = @cities.find { |city| city["id"] == @apply.city_id }
      @batch = @client.batch(@apply.batch_id)
    end
  end

  def employers
  end

  def stack
  end

  def robots
    respond_to :text
    expires_in 6.hours, public: true
  end

  def program
    @statistics = @client.statistics
  end

  def linkedin
    render json: params.to_json
  end

  def vae
  end

  def cgv
  end

  private

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
