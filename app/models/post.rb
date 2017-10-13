class Post
  include MarkdownArticle

  def video?
    layout.to_sym == :video
  end

  def post?
    layout.to_sym == :post
  end

  def story?
    false
  end

  def slug
    @slug ||= (Pathname.new(@file).basename.to_s[/\d{4}-\d{2}-\d{2}-(.*)\.md/, 1])
  end
end
