require "openssl"
require "base64"

class ProxyService
  include Cache
  PARAMETERS = %i(width height quality url)
  DEFAULT_JPEG_QUALITY = 90

  class Image < Struct.new(:blob, :type, :name)
  end

  def image(url, height, width, quality)
    from_cache(:proxy, url, height, width, quality, expire: 1.month) do
      mm_image = MiniMagick::Image.open(url)
      mm_image.resize "#{height}x#{width}" if height > 0 && width > 0
      mm_image.format url.end_with?("png") ? "png" : "jpg"
      mm_image.quality quality == 0 ? DEFAULT_JPEG_QUALITY : quality
      mm_image.strip
      name = URI.parse(url).path.split("/").last
      Image.new(mm_image.to_blob, mm_image.mime_type, name)
    end
  rescue OpenURI::HTTPError => e
    raise (Rails.env.production? ? e : "Could not find #{url}")
  end

  def sign(params)
    key = ENV.fetch('SECRET_BASE_KEY', Rails.env)
    data = params.slice(*PARAMETERS).sort_by { |k, _| k }.map { |t| t.last }.join
    Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), key, data)).strip
  end
end
