xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Le Wagon - Blog"
    xml.description "Le blog du Wagon vous tient informé de l'actualité technique et entrepreunariale. Retrouvez nos masterclasses et tutoriels vidéos. Formez-vous au code et découvrez les outils les plus utilisés par les startups innovantes."
    xml.link "http://www.lewagon.org/blog"

    Static::MEDIUM_POSTS.each do |post|
      xml.item do
        xml.title post.split('-')[0...-1].map(&:capitalize).join(" ")
        xml.link "https://medium.com/le-wagon/#{post}"
      end
    end

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.link "http://www.lewagon.org/blog/#{post.slug}"
        xml.description post.content
        xml.pubDate Time.parse("#{post.date} 09:00:00").rfc822()
      end
    end
  end
end
