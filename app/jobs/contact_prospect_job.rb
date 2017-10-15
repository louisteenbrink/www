class ContactProspectJob < ActiveJob::Base
  def perform(prospect_id)
    @prospect = Prospect.find(prospect_id)
    return if @prospect.city.blank? # Can't send the prospect email.

    city = Kitt::Client.query(City::Query, variables: { slug: @prospect.city }).data.city
    client = MeetupApiClient.new(city.meetup_id)
    meetups = client.meetup_events

    meetup_time = meetups.any? \
      ? Time.at(client.meetup_events.first["time"] / 1000)
      : nil

    less_than_a_week?(meetup_time) \
      ? send_event
      : send_content
  end

  rescue_from(Net::SMTPSyntaxError) do |exception|
    # Do nothing, email must be wrong.
  end

  private

  def send_event
    ProspectMailer.send_event(@prospect.id).deliver_later
  end

  def send_content
    ProspectMailer.send_content(@prospect.id).deliver_later
  end

  def less_than_a_week?(meetup_time)
    next_week = Time.now.tomorrow.beginning_of_day + ContactProspectsJob::TIME_SPAN
    meetup_time && meetup_time < next_week
  end
end
