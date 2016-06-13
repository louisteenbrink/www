# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  before_action :switch_to_french_if_needed, only: :home
  after_action :mark_as_tracked, only: :thanks

  def show
    render params[:template]
  end

  def home
    @stories = @client.random_stories(limit: 2, excluded_ids: (session[:story_ids] || []))
    @projects = @client.projects("home_projects")
    @testimonials = @client.testimonials(locale.to_s)
    @positions = @client.positions.take(8)
  end

  def thanks
    if session[:apply_id].blank?
      redirect_to root_path
    else
      @apply = Apply.find(session[:apply_id])
      cities = @client.cities
      @city = cities.select { |city| city["id"] == @apply.city_id }.first
      @batch = @city["batches"].select { |batch| batch["id"] == @apply.batch_id }.first
    end
  end

  def employers
    @positions = @client.positions
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
