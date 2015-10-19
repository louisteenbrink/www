require "trello"

class PushToTrelloRunner
  include MoneyRails::ActionViewExtension

  def initialize(apply, batch)
    @apply = apply
    @batch = batch
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_API_KEY']
      config.member_token = ENV['TRELLO_API_MEMBER_TOKEN']
    end
  end

  def run
    card = ::Trello::Card.new
    card.name = name
    card.list_id = list_id
    card.desc = <<-EOF
#{@apply.first_name} #{@apply.last_name} | #{@apply.age} | #{@apply.email} | #{@apply.phone}

## [Codecademy]()

## [Contrat]()

## Facture

Prix: #{humanized_money_with_symbol @batch.price} TTC

## Motivation

#{@apply.motivation}

## Interview

- **Background**:
- **Plans for after**:
- **English**:
- **Computer**:
EOF

    card.save

    checklist_json = JSON.parse(card.create_new_checklist("Payment"))
    checklist = ::Trello::Checklist.find(checklist_json["id"])
    checklist.add_item("Second Instalment paid")
    checklist.add_item("Balance paid")

    card
  end

  private

  def name
    Rails.env.production? ? @apply.email : "[#{@batch.id}] #{@apply.email}"
  end

  def list_id
    Rails.env.production? ? @batch.trello_inbox_list_id : '54024112c975d17cd1180489' # Will go to "TEST PROMOS in dev"
  end
end
