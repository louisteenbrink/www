module ProxyHelper
  # Usage:
  # proxy_url_with_signature(url: url, height: height, width: width, quality: quality)
  #   - url: an external URL you want to proxy
  #   - width (optional): if you want to perform an image resize, use this
  #   - height (optional): Same as width
  #   - quality (optional): Image will be converted to JPG by the proxy. Specify quality if necessary (default: 90)
  def proxy_url_with_signature(args = {})
    signature = ProxyService.new.sign(args)
    proxy_image_url args.merge(signature: signature)
  end
end
