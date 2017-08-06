require "mini_magick"

class ProxyController < ActionController::Base
  include ActiveSupport::SecurityUtils
  before_action :set_proxy_service
  before_action :check_signature

  def show
    url = params[:url]
    height = params[:height].to_i
    width = params[:width].to_i
    quality = params[:quality].to_i > 0 ? params[:quality].to_i : nil

    image = @proxy.image(url, height, width, quality)
    expires_in 1.month, public: true
    send_data image.blob, type: image.type, filename: image.name, disposition: :inline
  end

  private

  def set_proxy_service
    @proxy = ProxyService.new
  end

  def check_signature
    unless secure_compare(@proxy.sign(params.to_unsafe_h), params[:signature])
      render plain: 'Signature Error', status: 403
      return false
    end
  end
end
