class LinkedinClient
  def fetch(url)
    api = LinkedIn::API.new(ENV['LINKEDIN_TOKEN'])
    api.profile(url: url, fields: [
      "public_profile_url", "headline", "industry", "num_connections", "summary", "picture_urls::(original)",
      { "positions" => [ "title", "company", "start_date", "end_date" ] } ]
    )
  end
end
