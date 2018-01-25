class Post
  include MarkdownArticle

  FILENAME_PATTERN = /\d{4}-\d{2}-\d{2}-(.*)\.md/

  def video?
    layout.to_sym == :video
  end

  def post?
    layout.to_sym == :post
  end

  def story?
    false
  end

  def locale
    metadata[:locale]
  end

  def slug
    @slug ||= (Pathname.new(@file).basename.to_s[FILENAME_PATTERN, 1])
  end

  def date
    @date ||= Date.parse(Pathname.new(@file).basename.to_s[FILENAME_PATTERN, 0])
  end
end
