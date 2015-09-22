# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  before_action :set_locale
  before_action :set_client

  def home
    @stories = @client.stories
  end

  private

  def set_locale
    I18n.locale = params[:locale]
  end
  def set_client
    @client = AlumniClient.new
  end
end
