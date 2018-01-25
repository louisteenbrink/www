require "mini_magick"
require "base64"

class ProxyController < ActionController::Base
  include ActiveSupport::SecurityUtils
  before_action :set_proxy_service
  before_action :decode, unless: :empty_request?
  before_action :check_signature, unless: :empty_request?
  after_action :set_headers

  def image
    if empty_request?
      head 404
    else
      url = params[:url]
      height = params[:height].to_i
      width = params[:width].to_i
      quality = params[:quality].to_i

      image = @proxy.image(url, height, width, quality)
      expires_in 1.month, public: true

      send_data image.blob, type: image.type, filename: image.name, disposition: :inline
    end
  rescue URI::InvalidURIError, OpenURI::HTTPError
    head 404
  end

  private

  def decode
    result = JSON.parse(Base64.decode64(params[:request]))
    %i(url height width quality signature).each do |key|
      params[key] = result[key.to_s] if result[key.to_s]
    end
  rescue JSON::ParserError
    render plain: 'Invalid Request', status: 400
    return false
  end

  def set_proxy_service
    @proxy = ProxyService.new
  end

  def check_signature
    unless secure_compare(@proxy.sign(params.to_unsafe_h), params[:signature] || "")
      render plain: 'Signature Error', status: 403
      return false
    end
  end

  def empty_request?
    params[:request].blank?
  end

  def set_headers
    response.headers.except! 'X-Frame-Options'
    response.headers.except! 'X-XSS-Protection'
    response.headers.except! 'X-Content-Type-Options'
    response.headers["Cache-Control"] = "public, maxage=#{ProxyService::DEFAULT_EXPIRE.seconds.to_i}"
    response.headers["Expires"] = ProxyService::DEFAULT_EXPIRE.from_now.to_formatted_s(:rfc822)
  end
end
