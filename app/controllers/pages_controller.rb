# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  before_action :set_locale
  before_action :set_client
  after_action :mark_as_tracked, only: :thanks

  def show
    render params[:template]
  end

  def home
    @stories = @client.stories
    @projects = @client.projects(Static::SITE[:featured][:home])
    @cities = @client.cities
    @testimonials = @client.testimonials(locale.to_s)
    @meetups = Hash.new
    @cities.each do |city|
      if city["meetup_id"].present?
        meetup_cli = MeetupApiClient.new(city["meetup_id"])
        @meetups[city['slug']] = { events: meetup_cli.meetup_events, infos: meetup_cli.meetup  }
      end
    end
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

  private

  def set_locale
    I18n.locale = params[:locale]
  end

  def set_client
    @client = AlumniClient.new
  end

  def mark_as_tracked
    @apply.update tracked: true if @apply
  end
end
