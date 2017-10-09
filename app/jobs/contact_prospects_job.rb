class ContactProspectsJob < ActiveJob::Base
  TIME_SPAN = 7.days

  def perform
    start_time = Time.now - TIME_SPAN
    end_time = Time.now
    Prospect.where('created_at >= ? AND created_at < ?', start_time, end_time).each do |prospect|
      ContactProspectJob.perform_later(prospect.id)
    end
  end
end

Sidekiq::Cron::Job.create(
  name: 'Send Meetup invitation to last week Free Track subscribers',
  cron: '0 0 11 ? * 6', # every friday at 11 am.
  klass: 'ContactProspectsJob')
