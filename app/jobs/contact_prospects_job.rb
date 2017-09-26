class ContactProspectsJob < ActiveJob::Base
  TIME_SPAN = 7
  def perform
    Prospect.where('created_at >= ? AND created_at < ?', Time.now - TIME_SPAN.days , Time.now).each do |prospect|
      city = AlumniClient.new.city(prospect.city)
      meetup = MeetupApiClient.new(city.meetup_id)
      events = meetup.meetup_events

      if events.count >= 1
        ProspectMailer.send_event(prospect).deliver_now
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
