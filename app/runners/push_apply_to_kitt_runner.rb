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
  end

  private

  def price_cents
    # This is to avoid excess API calls in development
    Rails.env.production? ? (@apply.batch ? @apply.batch.price['cents'] : 0) : 600_000
  end

  def price_currency
    Rails.env.production? ? (@apply.batch ? @apply.batch.price['currency'] : 'EUR') : 'EUR'
  end
end
