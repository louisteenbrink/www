class ProspectsController < ApplicationController
  def create
    @prospect = Prospect.find_or_create_by(email: params[:prospect][:email], from_path: params[:prospect][:from_path], city: params[:prospect][:city])
    if @prospect.valid?
      ProspectMailer.invite(@prospect).deliver_later
      # Global NL
      SubscribeToNewsletter.new(@prospect.email).run({
        FROM_PATH: @prospect.from_path,
        FREE_TRACK: "true",
        CITY: @prospect.city
      })

      # City NL
      if params[:prospect][:city]
        city = AlumniClient.new.city(@prospect.city)
        if city.mailchimp?
          SubscribeToNewsletter.new(@prospect.email, list_id: city.mailchimp_list_id, api_key: city.mailchimp_api_key).run
        end
      end
    end
  end
end