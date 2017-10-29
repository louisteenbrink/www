class PushApplyToKittRunner
  def initialize(apply)
    @apply = apply
  end

  def run
    url = 'localhost:3001/applies'
    # url = 'https://kitt.lewagon.com/applies'

    payload = {
      camp_slug: @apply.batch_id,
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
        updated_at: @apply.updated_at
      }
    }

    begin
      RestClient.post url, payload.to_json, content_type: :json, accept: :json
    rescue => e
      puts e
    end
  end

  private

  def price_cents
    Rails.env.production? ? @apply.batch.price.cents : 100000
  end

  def price_currency
    Rails.env.production? ? @apply.batch.price.currency.to_s : 'EUR'
  end
end
