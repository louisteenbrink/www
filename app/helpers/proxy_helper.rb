module ProxyHelper
  def proxy_url_with_signature(args = {})
    signature = ProxyService.new.sign(args)
    proxy_image_url args.merge(signature: signature)
  end
end
