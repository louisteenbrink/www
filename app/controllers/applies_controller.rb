class AppliesController < ApplicationController
  before_action :set_locale
  before_action :set_client

  def new
    @cities = @client.cities.select{|city| !city['batches'].empty? }.each do |city|
      city['batches'].sort!{|batch| batch['starts_at'].to_date}.reverse!.each do |batch|
        batch['starts_at'] = batch['starts_at'].to_date.strftime('%B %d')
        batch['ends_at'] = batch['ends_at'].to_date.strftime('%B %d')
      end
    end.shuffle!
    @city = params[:city] ? @cities.find{|city| city['slug'] == params[:city]} : @cities.first
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
