class PushStudentToCrmRunner
  def initialize(trello_card, apply)
    @trello_card = trello_card
    @apply = apply
  end

  def run
    url = "#{ENV['CRM_BASE_URL']}/api/v1/cards"

    payload = {
      card: {
        trello_board_id: @trello_card.board.id,
        trello_card_id: @trello_card.id,
        email: @apply.email,
        first_name: @apply.first_name,
        last_name: @apply.last_name,
        age: @apply.age,
        phone_number: @apply.phone,
        motivation: @apply.motivation,
        price_cents: @apply.batch.price.cents,
        price_currency: @apply.batch.price.currency.to_s
      }
    }

    begin
      RestClient.post url, payload.to_json,
        content_type: :json,
        accept: :json,
        :'X-CRM-TOKEN' => ENV['CRM_TOKEN']
    rescue Exception => e
      puts e.message
    end
  end
end
