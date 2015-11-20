class CitiesController < ApplicationController
  def show
    @city = @client.city(params[:city])
    if I18n.locale == I18n.default_locale &&
        @city['course_locale'].to_sym != I18n.locale &&
        !session[:city_locale_already_forced] &&
        (env["HTTP_ACCEPT_LANGUAGE"] || "").split(",").first =~ /^#{Regexp.quote(@city['course_locale'])}/
      redirect_to city_path(params[:city], locale: @city['course_locale'])
      session[:city_locale_already_forced] = true
    else
      @teachers = @client.staff(params[:city])["teachers"]
      @assistants = @client.staff(params[:city])["teacher_assistants"]

      meetup_cli = MeetupApiClient.new(@city["meetup_id"])
      @meetup = { events: meetup_cli.meetup_events, infos: meetup_cli.meetup  }
      session[:city] = @city['slug']
    end
  end
end
