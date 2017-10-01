class ContactProspectsJob < ActiveJob::Base
  TIME_SPAN = 7
  TIME_SPAN_NEXT_EVENT = 8
  def perform
    Prospect.where('created_at >= ? AND created_at < ?', Time.now - TIME_SPAN.days , Time.now).each do |prospect|
      city = AlumniClient.new.city(prospect.city)
      meetup_cli = MeetupApiClient.new(city.meetup_id)
      meetups = meetup_cli.meetup_events

      if meetups.count >= 1
        meetup = { event: meetup_cli.meetup_events.first }
        meetup_time = Time.at(meetup[:event]["time"] / 1000)

        if meetup_time < Time.now + TIME_SPAN_NEXT_EVENT.days
          ProspectMailer.send_event(prospect).deliver_now
        else
          ProspectMailer.send_content(prospect).deliver_now
        end
      else
        ProspectMailer.send_content(prospect).deliver_now
      end
    end
  end
end

Sidekiq::Cron::Job.create(
  name: 'Send Meetup invitation to last week Free Track subscribers',
  cron: '0 0 11 ? * FRI *',
  klass: 'ContactProspectsJob')
