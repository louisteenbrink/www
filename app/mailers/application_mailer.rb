class ApplicationMailer < ActionMailer::Base
  default from: 'contact@lewagon.org'
  layout 'mailer'

  rescue_from Net::SMTPSyntaxError do |exception|
    puts exception
  end
end

