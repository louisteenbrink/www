class AppliesController < ApplicationController
  before_action :set_locale
  before_action :set_client

  def new
    @cities = @client.cities.select{|city| city['next_batch']}.each do |city|
      city['next_batch']['starts_at'] =  city['next_batch']['starts_at'].to_date.strftime('%A, %b %d')
      city['next_batch']['ends_at'] =  city['next_batch']['ends_at'].to_date.strftime('%A, %b %d')
    end.shuffle!
    @city = params[:city] ? @cities.select{|city| city['slug'] == params[:city]}[0] : @cities.first

  end

  def create
    #TODO
    redirect_to thanks_path(name: params[:first_name])
  end

  private
  def set_locale
    I18n.locale = params[:locale]
  end
  def set_client
    @client = AlumniClient.new
  end
end
