class NotifyErrorApplyJob < ActiveJob::Base
  def perform(city, apply_attributes, error_messages)
    yaml = apply_attributes.except("id", "created_at", "updated_at", "city_id").to_yaml.gsub("---\n", "")
    payload = {
      "channel": Rails.env.production? ? "students" : "test",
      "text": ":scream: Apply to *#{city}* failed. Here's the details :point_down:\n```\n#{yaml}```",
      "username": "www",
      "attachments": [
        "color": "#C94842",
        "attachment_type": "default",
        "fields": [
          {
            "title": "Errors",
            "value": error_messages.join("\n")
          },
        ]
      ]
    }

    RestClient.post ENV['TEAMWAGON_SLACK_INCOMING_WEBHOOK_URL'], payload.to_json,
      content_type: :json, accept: :json
  end
end
