
class TranslateMarkdown
  def initialize(content)
    @content = content
  end

  def run
    return "" if @content.blank?
    @markdown ||= (
      renderer = Redcarpet::Render::HTML.new
      Redcarpet::Markdown.new(renderer, extensions = {})
    )
    @markdown.render(@content).html_safe
  end
end
