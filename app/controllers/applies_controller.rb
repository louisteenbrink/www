class AppliesController < ApplicationController
  before_action :set_locale

  def new
    @application = Application.new
    prepare_apply_form
  end

  def create
    @application = Application.new(application_params)
    if @application.valid?
      # TODO
      redirect_to thanks_path(name: params[:first_name])
    else
      prepare_apply_form
      render :new
    end
  end

  private

  def prepare_apply_form
    @cities = client.cities.select{|city| !city['batches'].empty? }.each do |city|
      city['batches'].sort!{|batch| batch['starts_at'].to_date}.reverse!.each do |batch|
        batch['starts_at'] = batch['starts_at'].to_date.strftime('%B %d')
        batch['ends_at'] = batch['ends_at'].to_date.strftime('%B %d')
      end
    end.shuffle!
    @city = params[:city] ? @cities.find{|city| city['slug'] == params[:city]} : @cities.first
  end

  def set_locale
    I18n.locale = params[:locale]
  end

  def client
    @client ||= AlumniClient.new
  end

  def application_params
    params.require(:application).permit(*Application::PROPERTIES)
  end
end
