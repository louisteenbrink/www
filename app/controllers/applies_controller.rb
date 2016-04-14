class AppliesController < ApplicationController
  include MoneyRails::ActionViewExtension

  def new
    prepare_apply_form
    if @city.nil?
      redirect_to send(:"apply_#{locale}_path", city: 'paris')
    elsif params[:city].blank?
      redirect_to send(:"apply_#{locale}_path", city: @city['slug'])
    else
      @application = Apply.new(source: params[:source])
    end
  end

  def create
    @application = Apply.new(application_params)
    if @application.save
      session[:apply_id] = @application.id
      redirect_to send(:"thanks_#{I18n.locale}_path")
    else
      prepare_apply_form
      render :new
    end
  end

  private

  def prepare_apply_form
    @applicable_cities = @client.cities.select{ |city| !city['batches'].empty? }.each do |city|
      city['batches'].sort_by! { |batch| batch['starts_at'].to_date }

      city['batches'].each do |batch|
        batch['starts_at'] = I18n.l batch['starts_at'].to_date, format: :apply
        batch['ends_at'] = I18n.l batch['ends_at'].to_date, format: :apply
        batch['price'] = humanized_money_with_symbol Money.new(batch['price_cents'], batch['price_currency'])
      end
    end

    if params[:city]
      @city = @applicable_cities.find { |city| city['slug'] == params[:city] }
    elsif session[:city]
      @city = @applicable_cities.find { |city| city['slug'] == session[:city] }
    end
  end

  def application_params
    params.require(:application).permit(:first_name, :last_name, :email, :age, :phone, :motivation, :source, :batch_id, :city_id)
  end
end
