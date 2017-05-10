class NotifySlack < ActiveJob::Base
  def perform(payload)
    RestClient.post ENV['SLACK_INCOMING_WEBHOOK_URL'], payload.to_json, content_type: :json, accept: :json
  end
end
