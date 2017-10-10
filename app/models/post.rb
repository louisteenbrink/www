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
end
