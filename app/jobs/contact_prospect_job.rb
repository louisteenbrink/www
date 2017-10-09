class ContactProspectJob < ActiveJob::Base
  def perform(prospect_id)
    @prospect = Prospect.find(prospect_id)

    city = AlumniClient.new.city(@prospect.city) # TODO(krokrob): change this
    client = MeetupApiClient.new(city.meetup_id)
    meetups = client.meetup_events

    meetup_time = meetups.any? \
      ? Time.at(client.meetup_events.first["time"] / 1000)
      : nil

    less_than_a_week?(meetup_time) \
      ? send_event
      : send_content
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
