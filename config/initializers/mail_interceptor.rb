class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "[TO: #{message.to.join(", ")}] #{message.subject}"
    message.to = [ ENV.fetch('MY_EMAIL', 'seb@lewagon.org') ]
  end
end

if Rails.env.development? && ActionMailer::Base.delivery_method == :smtp
  ActionMailer::Base.register_interceptor(EmailInterceptor)
end
