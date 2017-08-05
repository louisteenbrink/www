require "net/http"

class ProxyController < ActionController::Base
  include Cache
  ALLOWED_ORIGINS = [
    /https?:\/\/raw.githubusercontent.com/
  ]
  def show
    url = params[:url]
    if ALLOWED_ORIGINS.any? { |origin| url =~ origin }
      data = from_cache(:proxy, url, expire: 1.year) do
        Net::HTTP.get_response(URI.parse(url))
      end
      # response.cache_control[:public] = true
      # response.headers['Cache-Control'] = 'public, max-age=31536000'
      # response.headers['Expires'] = 1.year.from_now.to_formatted_s(:rfc822)
      expires_in 1.year, public: true, "must-revalidate" => false
      send_data data.body, type: data.content_type, disposition: :inline
    else
      render plain: 'Not Authorized', status: 403
    end
  end
end
