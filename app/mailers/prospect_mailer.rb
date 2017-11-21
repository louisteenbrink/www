class ProspectMailer < ApplicationMailer
  after_action :prevent_emailing_opted_out_prospects, if: ->() { Rails.env.production? }
  after_action :prevent_double_deliveries, if: ->() { Rails.env.production? }

  class MissingCityProspectInformation < StandardError; end

  def invite(prospect_id)
    @prospect = Prospect.find(prospect_id)

    track user: @prospect
    mail(to: @prospect.email, subject: 'Join Le Wagon free online track!')
  rescue Net::SMTPSyntaxError => e
    puts "#{e.message} for #{@prospect.email}"
  end

  def send_event(prospect_id)
    @prospect = Prospect.find(prospect_id)

    @city = @prospect.city
    meetup_city = AlumniClient.new.city(@city)
    meetup_cli = MeetupApiClient.new(meetup_city.meetup_id)
    @meetup = { event: meetup_cli.meetup_events.first, infos: meetup_cli.meetup }
    @meetup_time = Time.at(@meetup[:event]["time"] / 1000)
    @city_info = CITIES[@city]
    if @city_info.blank?
      raise MissingCityProspectInformation.new("data/cities.yml does not have an entry for #{@city}. Ping @cedric")
    end
    @meetup_host = CITIES[@city]["meetup_host"]
    @user_locale = CITIES[@city]["marketing_automation"]["locale"]

    if CITIES[@city]["marketing_automation"]["enabled"]
      I18n.with_locale(@user_locale) do
        track user: @prospect
        mail \
          from: I18n.t('prospect_mailer.send_event.from',
                        meetup_host: @meetup_host["name"],
                        prospect_city: @prospect.city.capitalize,
                        email_city: @prospect.city),
          to: @prospect.email,
          subject: I18n.t('prospect_mailer.send_event.subject',
                          prospect_city: @prospect.city.capitalize,
                          meetup_time: l(@meetup_time, format: :event),
                          meetup_name: @meetup[:event]["name"])
      end
    end

  rescue Net::SMTPSyntaxError => e
    puts "#{e.message} for #{@prospect.email}"
  end

  def send_content(prospect_id)
    @prospect = Prospect.find(prospect_id)
    @city = @prospect.city
    @city_info = CITIES[@city]

    if CITIES[@city]["marketing_automation"]["enabled"]
      @meetup_host = CITIES[@city]["meetup_host"]
      @user_locale = CITIES[@city]["marketing_automation"]["locale"]

      I18n.with_locale(@user_locale) do
        track user: @prospect
        mail \
          from: I18n.t('prospect_mailer.send_event.from',
                        meetup_host: @meetup_host["name"],
                        prospect_city: @prospect.city.capitalize,
                        email_city: @prospect.city),
          to: @prospect.email,
          subject: I18n.t('prospect_mailer.send_content.subject')
      end
    end
  rescue Net::SMTPSyntaxError => e
    puts "#{e.message} for #{@prospect.email}"
  end

  private

  def prevent_emailing_opted_out_prospects
    mail.perform_deliveries = !@prospect.opted_out?
  end

  def prevent_double_deliveries
    mail.perform_deliveries = @prospect.messages.
      where(mailer: "#{self.class.name}##{action_name}").
      where.not(sent_at: nil).
      empty?
  end
end
