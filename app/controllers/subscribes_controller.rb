class SubscribesController < ApplicationController
  respond_to :json

  def create
    response = SubscribeToNewsletter.new(params[:email]).run
    if params[:city_id].present?
      city = AlumniClient.new.city(params[:city_id])
      if city.mailchimp?
        SubscribeToNewsletter.new(params[:email], list_id: city.mailchimp_list_id, api_key: city.mailchimp_api_key).run
      end
    end
    render json: response
  end
end
