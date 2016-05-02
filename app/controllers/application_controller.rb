require "static"
require "timeout"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :set_client
  before_action :fetch_live

  before_action :load_static, if: -> { Rails.env.development? }
  before_action :load_cities

  # before_action :authenticate_user!, unless: :pages_controller?

  # after_action :verify_authorized, except:  :index, unless: :devise_or_pages_controller?
  # after_action :verify_policy_scoped, only: :index, unless: :devise_or_pages_controller?

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActionController::UnknownFormat, with: :render_404

  def default_url_options
    { locale: ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
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
    @cities = @client.cities
  end

  def render_404
    respond_to do |format|
      format.html { render 'pages/404', status: :not_found }
      format.text { render text: 'Not Found', status: :not_found }
    end
  end

  def set_client
    @client ||= AlumniClient.new
  end

  def fetch_live
    Timeout::timeout(1) do
      @live_batch = @client.live_batch
    end
  rescue Exception => e
    puts e
  ensure
    @live_batch ||= { "live" => false }
  end
end
