class HealthCheckJob < ActiveJob::Base
  queue_as :default

  def perform
    require 'net/http'

    if ENV['HEALTH_CHECK_URL'].present?
      Net::HTTP.get(URI(ENV['HEALTH_CHECK_URL']))
    else
      Rails.logger.warn("Cannot report good health. No HEALTH_CHECK_URL found in ENV.")
    end
  end
end

Sidekiq::Cron::Job.create(
  name: 'Notify healthchecks.io that a sidekiq worker is running',
  cron: '*/5 * * * *',
  klass: 'HealthCheckJob')
