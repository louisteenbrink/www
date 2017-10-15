class ContactProspectJob < ActiveJob::Base
  def perform(prospect_id)
    @prospect = Prospect.find(prospect_id)
    return if @prospect.city.blank? # Can't send the prospect email.

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

  rescue_from(Net::SMTPSyntaxError) do |exception|
    # Do nothing, email must be wrong.
  end

  private

  def send_event
    mailer = ProspectMailer.send_event(@prospect.id)
    mailer.deliver_later if mailer.to
  end

  def send_content
    mailer = ProspectMailer.send_content(@prospect.id)
    mailer.deliver_later if mailer.to
  end

  def less_than_a_week?(meetup_time)
    next_week = Time.now.tomorrow.beginning_of_day + ContactProspectsJob::TIME_SPAN
    meetup_time && meetup_time < next_week
  end
end
