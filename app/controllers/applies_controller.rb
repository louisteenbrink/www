# == Schema Information
#
# Table name: applies
#
#  id                  :integer          not null, primary key
#  first_name          :string
#  last_name           :string
#  age                 :integer
#  email               :string
#  phone               :string
#  motivation          :text
#  batch_id            :integer
#  city_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  tracked             :boolean          default(FALSE), not null
#  source              :string
#  codecademy_username :string
#  linkedin            :string
#

class AppliesController < ApplicationController
  include MoneyRails::ActionViewExtension

  def new
    if session[:apply_id].present?
      apply = Apply.where(id: session[:apply_id]).first
      if apply && (apply.created_at + 1.day) > Time.now
        return redirect_to send(:"thanks_#{locale.to_s.underscore}_path", already: true)
      else
        session[:apply_id] = nil
      end
    end

    prepare_apply_form

    if @city.nil?
      redirect_to send(:"apply_#{locale.to_s.underscore}_path", city: @applicable_cities.first.slug)
    elsif params[:city].blank?
      redirect_to send(:"apply_#{locale.to_s.underscore}_path", city: @city.slug)
    else
      @application = Apply.new(source: params[:source])
      set_validate_ruby
    end
  end

  def create
    @application = Apply.new(application_params)
    set_validate_ruby

    if @application.save
      session[:apply_id] = @application.id
      redirect_to send(:"thanks_#{I18n.locale.to_s.underscore}_path")
    else
      city = Kitt::Client.query(City::Query, variables: { id: @application.city_id }).data.city
      prepare_apply_form
      render :new
    end
  end

  def validate
    @application = Apply.new(application_params)
    set_validate_ruby
    @application.valid?
  end

  def new_hec
    I18n.locale = :fr
    @application = Apply.new
    @hide_language_selector = true
    @hide_banner_apply_button = true
  end

  def create_hec
    I18n.locale = :fr
    @application = Apply.new(application_params)
    @application.motivation = "HEC CANDIDATE\n\n#{@application.motivation}"
    @application.batch_id = 153 # HEC - Paris - Janvier 2018
    @application.city_id = 1    # Paris
    # @application.validate_ruby_codecademy_completed = true
    @application.skip_source_validation = true # No referrer

    if @application.save
      session[:apply_id] = @application.id
      redirect_to thanks_fr_path
    else
      @hide_language_selector = true
      @hide_banner_apply_button = true
      render :new_hec
    end
  end

  private

  include CloudinaryHelper
  include CitiesHelper

  def prepare_apply_form
    @applicable_cities = Kitt::Client.query(City::ApplyQuery).data.cities.select{ |city| !city.apply_batches.empty? }
    # Sort by first available batch
    @applicable_cities.sort do |city_a, city_b|
      if next_open_batch_date(city_a) == next_open_batch_date(city_b)
        city_a.name <=> city_b.name
      else
        next_open_batch_date(city_a) <=> next_open_batch_date(city_b)
      end
    end

    if params[:city]
      @city = @applicable_cities.find { |city| city.slug == params[:city] }
    elsif session[:city]
      @city = @applicable_cities.find { |city| city.slug == session[:city] }
    end

    @apply_city_groups = @city_groups.map do |city_group|
      slugs = city_group[:cities].map { |city| city.slug }
      apply_city_group = city_group.clone
      apply_city_group[:cities] = @applicable_cities.select { |applicable_city| slugs.include?(applicable_city.slug) }
      apply_city_group
    end

    @city_group = @apply_city_groups.find { |city_group| city_group[:cities].map { |city| city.slug }.include?(@city.slug) } unless @city.nil?
  end

  def application_params
    params.require(:application).permit(:first_name, :last_name, :email, :age, :phone, :motivation, :source, :batch_id, :city_id, :codecademy_username, :linkedin)
  end

  def set_validate_ruby
    return unless @application.batch_id

    batch = Kitt::Client.query(Batch::Query, variables: { id: @application.batch_id }).data.batch
    if batch.force_completed_codecademy_at_apply
      @application.validate_ruby_codecademy_completed = true
    end
  end
end
