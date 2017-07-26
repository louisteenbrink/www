require "static"
require "timeout"
require 'open-uri'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, except: :render_404
  before_action :set_locale
  before_action :set_clients
  before_action :set_live

  before_action :load_static, if: -> { Rails.env.development? }
  before_action :load_cities

  # before_action :authenticate_user!, unless: :pages_controller?

  # after_action :verify_authorized, except:  :index, unless: :devise_or_pages_controller?
  # after_action :verify_policy_scoped, only: :index, unless: :devise_or_pages_controller?

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActionController::UnknownFormat, with: :render_404
  rescue_from RestClient::ResourceNotFound, with: :render_404  # From Alumni API

  def default_url_options
    { locale: ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
  end

  def render_404
    respond_to do |format|
      format.html { render 'pages/404', status: :not_found }
      format.all { render text: 'Not Found', status: :not_found }
    end
  end

  def render_500
    render 'pages/500', status: 500
  end

  before_action :better_errors_hack, if: -> { Rails.env.development? }

  def better_errors_hack
    request.env['puma.config'].options.user_options.delete :app
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
    @city_groups = @kitt_client.city_groups
    # needed in footer
    @cities = @city_groups.map { |city_group| city_group[:cities] }.flatten
  end

  def set_clients
    @client ||= AlumniClient.new
    @kitt_client ||= KittClient.new
  end

  def set_live
    @live = Live.running_now
  end
end
