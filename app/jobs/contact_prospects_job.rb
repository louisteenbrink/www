class ContactProspectsJob < ActiveJob::Base
  TIME_SPAN = 7.days

  def perform
    Prospect.where('created_at >= ? AND created_at < ?', Time.now - TIME_SPAN , Time.now).each do |prospect|
      ContactProspectJob.perform_now(prospect)
    end
  end
end

Sidekiq::Cron::Job.create(
  name: 'Send Meetup invitation to last week Free Track subscribers',
  cron: '0 0 11 ? * FRI *',
  klass: 'ContactProspectsJob')
