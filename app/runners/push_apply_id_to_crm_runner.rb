class PushApplyIdToCrmRunner
  def initialize(email)
    @apply = Apply.find_by_email(email)
  end

  def run
    payload = {
      card: {
        email: @apply.email,
        www_apply_id: @apply.id
      }
    }
    begin
      RestClient.post("#{ENV['CRM_BASE_URL']}/api/v1/cards/update_www_apply_id",
       payload.to_json, {
        content_type: :json,
        accept: :json,
        :'X-CRM-TOKEN' => ENV['CRM_TOKEN']
        }
      )
    rescue RestClient::UnprocessableEntity => e
      raise e
    end
  end
end
