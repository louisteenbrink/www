class CitiesController < ApplicationController
  before_action :set_locale
  before_action :set_client

  def show
    @city = @client.city(params[:city])
    @teachers = @client.staff(params[:city])["teachers"]
    @assistants = @client.staff(params[:city])["teacher_assistants"]
    meetup_cli = MeetupApiClient.new(@city["meetup_id"])
    @meetup = { events: meetup_cli.meetup_events, infos: meetup_cli.meetup  }
  end

  private
  def set_locale
    I18n.locale = params[:locale]
  end
  def set_client
    @client = AlumniClient.new
  end
end
