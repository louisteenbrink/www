require "mini_magick"
require "base64"

class ProxyController < ActionController::Base
  include ActiveSupport::SecurityUtils
  before_action :set_proxy_service
  before_action :decode, unless: :empty_request?
  before_action :check_signature, unless: :empty_request?

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
  end

  private

  def decode
    result = JSON.parse(Base64.decode64(params[:request]))
    %i(url height width quality signature).each do |key|
      params[key] = result[key.to_s] if result[key.to_s]
    end
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
end
