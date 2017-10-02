class ContactProspectJob < ActiveJob::Base
  def perform(prospect)
    city = AlumniClient.new.city(prospect.city)
    meetup_cli = MeetupApiClient.new(city.meetup_id)
    meetups = meetup_cli.meetup_events

    if meetups.count >= 1
      meetup = { event: meetup_cli.meetup_events.first }
      meetup_time = Time.at(meetup[:event]["time"] / 1000)

      if meetup_time < Time.now + 8.days
        ProspectMailer.send_event(prospect).deliver_now
      else
        ProspectMailer.send_content(prospect).deliver_now
      end
    else
      ProspectMailer.send_content(prospect).deliver_now
    end
  end
end