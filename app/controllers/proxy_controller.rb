require "mini_magick"

class ProxyController < ActionController::Base
  include Cache
  ALLOWED_ORIGINS = [
    /https?:\/\/raw.githubusercontent.com/
  ]

  DEFAULT_JPEG_QUALITY = 90

  def show
    url = params[:url]
    width = params[:width].to_i
    height = params[:height].to_i
    quality = params[:quality].to_i > 0 ? params[:quality].to_i : DEFAULT_JPEG_QUALITY

    if ALLOWED_ORIGINS.any? { |origin| url =~ origin }
      image = from_cache(:proxy, url, width, height, quality, expire: 1.month) do
        mm_image = MiniMagick::Image.open(url)
        mm_image.resize "#{height}x#{width}" if height > 0 && width > 0
        mm_image.format "jpg"
        mm_image.quality quality
        {
          blob: mm_image.to_blob,
          type: mm_image.mime_type,
          name: URI.parse(url).path.split("/").last
        }
      end
      expires_in 1.month, public: true
      send_data image[:blob], type: image[:type], filename: image[:name], disposition: :inline
    else
      render plain: 'Not Authorized', status: 403
    end
  end
end
