class Mailgun
  def validate_email(email)
    url = "https://api:#{ENV['MAILGUN_PUBLIC_API_KEY']}@api.mailgun.net/v3/address/validate"
    response = JSON.parse(
      RestClient::Request.execute(
        method: :get,
        url: url,
        payload: { address: email },
        user: 'api',
        password: ENV['MAILGUN_PUBLIC_API_KEY']
      )
    )
  end
end
