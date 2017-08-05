require "net/http"

class ProxyController < ActionController::Base
  include Cache
  ALLOWED_ORIGINS = [
    /https?:\/\/raw.githubusercontent.com/
  ]
  def show
    url = params[:url]
    if ALLOWED_ORIGINS.any? { |origin| url =~ origin }
      data = from_cache(:proxy, url, expire: 1.month) do
        Net::HTTP.get_response(URI.parse(url))
      end
      expires_in 1.month, public: true
      send_data data.body, type: data.content_type, disposition: :inline
    else
      render plain: 'Not Authorized', status: 403
    end
  end
end
