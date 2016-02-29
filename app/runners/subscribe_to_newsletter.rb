require "gibbon"

class SubscribeToNewsletter
  def initialize(email, options = {})
    @gibbon = Gibbon::Request.new(api_key: options.fetch(:api_key, ENV['MAILCHIMP_API_KEY']))
    @list_id = options.fetch(:list_id, ENV['MAILCHIMP_LIST_ID'])
    @email = email
  end

  def run
    begin
      @gibbon.lists(@list_id).members.create(
        body: {
          email_address: @email,
          status: "subscribed"
        }
      )
      return { ok: true, already_subscribed: false }
    rescue Gibbon::MailChimpError => e
      if e.body["detail"] =~ /is already a list member/
        return { ok: true, already_subscribed: true }
      else
        return { ok: false, message: e.body["detail"], errors: e.body['errors'] }
      end
    end
  end
end
