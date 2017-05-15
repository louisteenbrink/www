xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Le Wagon Blog - Code Matters"
    xml.description "ringing you the latest news, tutorials and insights on coding and entrepreneurship"
    xml.link "https://www.lewagon.com/blog"

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.link "https://www.lewagon.com/blog/#{post.slug}"
        xml.description markdown(post.content)
        xml.pubDate post.date.rfc822()
      end
    end
  end
end
