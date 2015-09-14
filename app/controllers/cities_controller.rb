class CitiesController < ApplicationController
  def show
    @city = Static::CITIES[params[:city].to_sym]
  end
end
