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
    meetups_organizer = YAML.load_file(Rails.root.join("data/cities.yml"))
    @meetup_host = meetups_organizer[@city]["meetup_host"]

    mail(to: prospect.email, subject: "Come to our next free event in #{prospect.city} next #{@meetup_time.strftime("%A")}: #{@meetup[:event]["name"]}!")

  rescue Net::SMTPSyntaxError => e
    puts "#{e.message} for #{@prospect.email}"
    @prospect.destroy
  end

  def send_content(prospect)
    mail(to: prospect.email, subject: "We are bringing you the latest news, tutorials and
insights on coding and entrepreneurship!")

  rescue Net::SMTPSyntaxError => e
    puts "#{e.message} for #{@prospect.email}"
    @prospect.destroy
  end
end
