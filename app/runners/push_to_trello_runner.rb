require "trello"
require "open-uri"

class PushToTrelloRunner
  include MoneyRails::ActionViewExtension

  def initialize(apply)
    @apply = apply
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_API_KEY']
      config.member_token = ENV['TRELLO_API_MEMBER_TOKEN']
    end
  end

  def run
    if @apply.codecademy_username.blank?
      codecademy = "## [Codecademy]()"
    else
      codecademy = "## [Codecademy](https://codecademy-checker.herokuapp.com/#{@apply.codecademy_username})"
    end

    linkedin = "No profile specified"
    if @apply.linkedin_profile
      if @apply.linkedin_profile[:first_name] == "private"
        linkedin = "[View Profile](#{@apply.linkedin})"
      else
        positions = nil
        if @apply.linkedin_profile[:positions] && @apply.linkedin_profile[:positions][:total] > 0 && @apply.linkedin_profile[:positions][:all]
          positions = "### Positions\n"
          @apply.linkedin_profile[:positions][:all].each do |position|
            if position[:start_date]
              positions << "#{position[:start_date][:year]} - #{position[:title]} @ #{position[:company][:name]}\n"
            else
              positions << "#{position[:title]} @ #{position[:company][:name]}\n"
            end
          end
        end

        linkedin = <<-EOF
#{@apply.linkedin_profile[:headline]}
#{@apply.linkedin_profile[:industry]}

[View Linkedin Profile](#{@apply.linkedin_profile[:public_profile_url]}) - #{@apply.linkedin_profile[:num_connections] == 500 ? '500+' : @apply.linkedin_profile[:num_connections]} connections

### Summary

#{@apply.linkedin_profile[:summary]}

#{positions}
EOF
      end
    end

    card = ::Trello::Card.new
    card.name = name
    card.list_id = list_id
    card.desc = <<-EOF
#{@apply.first_name} #{@apply.last_name} | #{@apply.age} | #{@apply.email} | #{@apply.phone}

#{codecademy}

## [Contract]()

## Invoice

Price: #{price.currency.iso_code} #{humanized_money price}

## Referrer

#{@apply.source}

## Linkedin

#{linkedin}

## Motivation

#{@apply.motivation}

## Interview

Who's doing the interview? 👉

**Background**

**Plans for after**

**How did you first hear about us?**

**Did you attend a meetup? How many?**

**English Level**

**Computer**

EOF

    card.save

    checklist_json = JSON.parse(card.create_new_checklist("Payment"))
    checklist = ::Trello::Checklist.find(checklist_json["id"])
    checklist.add_item("Second Instalment paid")
    checklist.add_item("Balance paid")

    if @apply.linkedin_profile && @apply.linkedin_profile[:picture_urls] && @apply.linkedin_profile[:picture_urls][:total] > 0
      url = @apply.linkedin_profile[:picture_urls][:all].first
      if url
        file = Tempfile.new(["linkedin_picture", ".jpg"])
        file.binmode
        begin
          file.write open(url).read
          card.add_attachment(File.open(file.path), "linkedin_picture.jpg")
        rescue Exception => e
          file.close
          file.unlink
          raise e
        end
      end
    end

    card
  end

  private

  def name
    Rails.env.production? ? @apply.email : "[Test] #{@apply.email}"
  end

  def list_id
    Rails.env.production? ? @apply.batch.trello_inbox_list_id : ENV['TRELLO_DEV_LIST_ID']
  end

  def price
    Rails.env.production? ? @apply.batch.price : Money.new(1000, 'EUR')
  end
end
