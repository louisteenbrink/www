require 'open-uri'

class ReviewsCounter
  include Cache

  def review_count
    from_cache(:total_review_count) do
      html_coursereport = Nokogiri::HTML(open("https://www.coursereport.com/schools/le-wagon#/reviews"))
      coursereport_data = html_coursereport.search("span[itemprop='reviewCount']").text.to_i

      html_switchup = Nokogiri::HTML(open("https://www.switchup.org/bootcamps/le-wagon"))
      switchup_data = html_switchup.search("span[itemprop='reviewcount']").text.to_i

      return coursereport_data + switchup_data
    end
  end
end