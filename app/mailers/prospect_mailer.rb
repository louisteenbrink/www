class ProspectMailer < ApplicationMailer
  def invite(prospect)
    @prospect = prospect

    mail(to: @prospect.email, subject: 'Join Le Wagon free online track!')
  rescue Net::SMTPSyntaxError => e
    puts "#{e.message} for #{@prospect.email}"
    @prospect.destroy
  end

  def send_event(prospect)
    @city = prospect.city
    meetup_city = AlumniClient.new.city(@city)
    meetup_cli = MeetupApiClient.new(meetup_city.meetup_id)
    @meetup = { event: meetup_cli.meetup_events.first, infos: meetup_cli.meetup }
    @meetup_time = Time.at(@meetup[:event]["time"] / 1000)
    cities_data = YAML.load_file(Rails.root.join("data/cities.yml"))
    @meetup_host = cities_data[@city]["meetup_host"]
    @user_locale = cities_data[@city]["marketing_automation"]["locale"]

    if cities_data[@city]["marketing_automation"]["enabled"] == true
      I18n.with_locale(@user_locale) do
        mail(
          to: prospect.email,
          subject: I18n.t('prospect_mailer.send_event.subject', prospect_city: prospect.city.capitalize, meetup_time: l(@meetup_time, format: :event), meetup_name: @meetup[:event]["name"])
        )
      end
    end

  rescue Net::SMTPSyntaxError => e
    puts "#{e.message} for #{@prospect.email}"
    @prospect.destroy
  end

  def send_content(prospect)
    @city = prospect.city
    cities_data = YAML.load_file(Rails.root.join("data/cities.yml"))
    @meetup_host = cities_data[@city]["meetup_host"]
    @user_locale = cities_data[@city]["marketing_automation"]["locale"]

    if cities_data[@city]["marketing_automation"]["enabled"] == true
      I18n.with_locale(@user_locale) do
        mail(
          to: prospect.email,
          subject: I18n.t('prospect_mailer.send_content.subject')
        )
      end
    end

  rescue Net::SMTPSyntaxError => e
    puts "#{e.message} for #{@prospect.email}"
    @prospect.destroy
  end
end
