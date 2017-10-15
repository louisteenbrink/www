class SubscribesController < ApplicationController
  respond_to :json

  def create
    response = SubscribeToNewsletter.new(params[:email]).run
    if params[:city_slug].present?
      city = Kitt::Client.query(City::Query, variables: { slug: params[:city_slug] }).data.city
      if city.mailchimp_list_id.present? && city.mailchimp_list_id.present?
        SubscribeToNewsletter.new(
          params[:email], list_id: city.mailchimp_list_id, api_key: city.mailchimp_api_key).run
      end
    end
    render json: response
  end
end
