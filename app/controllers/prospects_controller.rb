class ProspectsController < ApplicationController
  def create
    @prospect = Prospect.find_or_create_by(
      email: params[:prospect][:email],
      from_path: params[:prospect][:from_path],
      city: params[:prospect][:city])

    if @prospect.valid?
      ProspectMailer.invite(@prospect.id).deliver_later

      # Global NL
      SubscribeToNewsletter.new(@prospect.email).run({
        FROM_PATH: @prospect.from_path,
        FREE_TRACK: "true",
        CITY: @prospect.city,
        LOCALE: I18n.locale.to_s
      })

      # City NL
      if params[:prospect][:city]
        city = Kitt::Client.query(City::Query, variables: { id: @prospect.city }).data.city
        if city.mailchimp_list_id.present? && city.mailchimp_list_id.present?
          SubscribeToNewsletter.new(@prospect.email,
            list_id: city.mailchimp_list_id, api_key: city.mailchimp_api_key).run
        end
      end
    end
  end
end
