class ProspectMailer < ApplicationMailer
  def invite(prospect)
    @prospect = prospect

    mail(to: @prospect.email, subject: 'Join Le Wagon free online track!')
  rescue Net::SMTPSyntaxError => e
    puts "#{e.message} for #{@prospect.email}"
    @prospect.destroy
  end
end