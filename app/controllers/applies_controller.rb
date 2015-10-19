class AppliesController < ApplicationController
  include MoneyRails::ActionViewExtension

  before_action :set_locale

  def new
    @application = Apply.new
    prepare_apply_form
  end

  def create
    @application = Apply.new(application_params)
    if @application.save
      session[:apply_id] = @application.id
      redirect_to thanks_path
    else
      prepare_apply_form
      render :new
    end
  end

  private

  def prepare_apply_form
    @cities = client.cities.select{|city| !city['batches'].empty? }.each do |city|
      city['batches'].sort!{|batch| batch['starts_at'].to_date}.reverse!.each do |batch|
        batch['starts_at'] = batch['starts_at'].to_date.strftime('%B %e, %Y')
        batch['ends_at'] = batch['ends_at'].to_date.strftime('%B %e, %Y')
        batch['price'] = humanized_money_with_symbol Money.new(batch['price_cents'], batch['price_currency'])
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
    params.require(:application).permit(:first_name, :last_name, :email, :age, :phone, :motivation, :batch_id, :city_id)
  end
end
