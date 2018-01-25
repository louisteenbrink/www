require "static"
require "timeout"
require 'open-uri'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session, except: :render_404
  before_action :redirect_on_referer
  before_action :fetch_critical_css, if: -> { Rails.env.production? }
  before_action :set_locale
  before_action :set_live

  before_action :load_static, if: -> { Rails.env.development? }
  before_action :load_cities

  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActionController::UnknownFormat, with: :render_404
  rescue_from RestClient::ResourceNotFound, with: :render_404  # From Alumni API

  def default_url_options
    { locale: ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
  end

  def render_404
    respond_to do |format|
      format.html { render 'pages/404', status: :not_found }
      format.all { render plain: 'Not Found', status: :not_found }
    end
  end

  private

  def devise_or_pages_controller?
    devise_controller? || pages_controller?
  end

  def pages_controller?
    controller_name == "pages"  # Brought by the `high_voltage` gem
  end

  def user_not_authorized
    flash[:error] = I18n.t('controllers.application.user_not_authorized', default: "You can't access this page.")
    redirect_to(root_path)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def load_static
    Static.load
  end

  def load_cities
    # needed in navbar
    cities = Kitt::Client.query(City::GroupsQuery).data.cities
    @city_groups ||= Static::CITY_GROUPS.map do |group|
      group[:cities] = group[:city_slugs].map do |slug|
        cities.find { |city| city.slug == slug }
      end
      group[:cities].compact!
      group
    end
    # needed in footer
    @cities = @city_groups.map { |city_group| city_group[:cities] }.flatten
  end

  def set_live
    @live = Live.running_now
  end

  def fetch_critical_css
    critical_path_css_routes = CriticalPathCss::Rails::ConfigLoader.new.load["routes"]
    if request.get? && request.format.html? && critical_path_css_routes.include?(request.path)
      @critical_css = CriticalPathCss.fetch(request.path)
      if @critical_css.empty?
        # Wait 5 minutes to be sure that Heroku deployment is complete and server ready (preload enabled)
        GenerateCriticalCssJob.set(wait: 5.minutes).perform_later(request.path)
      end
    end
  end

  def redirect_on_referer
    return if ENV['REDIRECT_ON_REFERER'].blank?

    if request.referer =~ /#{ENV['REDIRECT_ON_REFERER']}/
      redirect_to "https://www.switchup.org/research/best-coding-bootcamps"
      false
    end
  end
end
