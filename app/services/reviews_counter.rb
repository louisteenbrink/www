require 'open-uri'

class ReviewsCounter
  include Cache

  def review_count
    from_cache(:total_review_count) do
      begin
        html_coursereport = Nokogiri::HTML(open("https://www.coursereport.com/schools/le-wagon#/reviews"))
        coursereport_data = html_coursereport.search("span[itemprop='reviewCount']").text.to_i
      rescue OpenURI::HTTPError, SocketError => e
        coursereport_data = 0
        raise e if Rails.env.development?
      end

      html_switchup = Nokogiri::HTML(open("https://www.switchup.org/bootcamps/le-wagon"))
      switchup_data = html_switchup.search("span[itemprop='reviewcount']").text.to_i

      ((coursereport_data + switchup_data)/ 5) * 5
    end
  end
end
