module ProxyHelper
  def proxy_url_with_signature(args = {})
    signature = ProxyService.new.sign(args)
    proxy_url args.merge(signature: signature)
  end
end
