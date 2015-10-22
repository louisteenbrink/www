module ApplicationHelper
  def image_url_with_fallback(image_url)
    if image_url.strip.empty?
      image_path 'social/home_facebook_card.png'
    else
      image_url.strip
    end
  end

  def markdown(content)
    return "" if content.blank?
    @markdown ||= (
      renderer = Redcarpet::Render::HTML.new
      Redcarpet::Markdown.new(renderer, extensions = {})
    )
    @markdown.render(content).html_safe
  end

  def structure(hash)
    object = JSON.parse(hash.to_json, object_class: OpenStruct)
  end
end
