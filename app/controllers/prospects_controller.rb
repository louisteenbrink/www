class ProspectsController < ApplicationController
  def create
    @prospect = Prospect.find_or_create_by(email: params[:prospect][:email], from_path: params[:prospect][:from_path], city: params[:prospect][:city])
    if @prospect.valid?
      ProspectMailer.invite(@prospect).deliver_later
      # Global NL
      SubscribeToNewsletter.new(@prospect.email, from_path: @prospect.from_path, free_track: true, city: @prospect.city).run

      # City NL
      if params[:prospect][:city]
        city_id = @cities.find {|city| city["name"] == params[:prospect][:city]}["city_id"]
        city = AlumniClient.new.city(city_id)
        if city.mailchimp?
          SubscribeToNewsletter.new(@prospect.email, list_id: city.mailchimp_list_id, api_key: city.mailchimp_api_key, from_path: @prospect.from_path, free_track: true).run
        end
      end
    end
  end
end
