class PushApplyToKittRunner
  def initialize(apply)
    @apply = apply
  end

  def run
    if !Rails.env.production? && ENV["KITT_BASE_URL"] =~ /kitt\.lewagon\.com/
      fail "[SAFETY NET] Do not send local applies to production Kitt!"
    end

    payload = {
      camp_id: @apply.batch_id,
      apply: {
        email: @apply.email,
        first_name: @apply.first_name,
        last_name: @apply.last_name,
        codecademy_username: @apply.codecademy_username,
        linkedin: @apply.linkedin,
        age: @apply.age,
        phone_number: @apply.phone,
        source: @apply.source,
        motivation: @apply.motivation,
        price_cents: price_cents,
        price_currency: price_currency,
        created_at: @apply.created_at,
        updated_at: @apply.updated_at,
        www_apply_id: @apply.id
      }
    }

    RestClient.post("#{ENV['KITT_BASE_URL']}/api/v1/applies", payload.to_json, { content_type: :json })
  rescue RestClient::UnprocessableEntity => e
    body = JSON.parse e.response.body
    if body["www_apply_id"].first =~ /already been taken/
      # Kitt already knows this candidate
    else
      raise e
    end
  end

  private

  def price_cents
    batch ? batch.price["cents"] : 0
  end

  def price_currency
    batch ? batch.price["currency"] : "EUR"
  end

  def batch
    @batch = (
      begin
        @apply.batch
      rescue Kitt::Client::Error
        nil
      end
    )
  end
end
