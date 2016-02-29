module Api
  class City
    def initialize(json)
      @json = json
    end

    def [](key)
      @json[key]
    end

    def method_missing(method)
      @json[method.to_s]
    end

    def mailchimp?
      @json["mailchimp_list_id"].present?
    end

    def mailchimp_api_key
      @mailchimp_api_key ||= (
        return nil if @json['encrypted_mailchimp_api_key'].blank?
        key   = ActiveSupport::KeyGenerator.new(ENV['ALUMNI_WWW_ENCRYPING_KEY']).generate_key(@json['id'].to_s)
        crypt = ActiveSupport::MessageEncryptor.new(key)
        crypt.decrypt_and_verify(@json["encrypted_mailchimp_api_key"])
      )
    end
  end
end
