module Teacher
  BatchQuery = Kitt::Client.parse <<-'GRAPHQL'
    query($batch_slug: String!) {
      teachers: camp_teachers(camp_slug: $batch_slug) {
        id
        name
        github_nickname
        official_avatar_url
        lecturer
        twitter_url
        bio_en
        bio_fr
      }
    }
  GRAPHQL

  CityQuery = Kitt::Client.parse <<-'GRAPHQL'
    query($city_slug: String!) {
      teachers: city_teachers(city_slug: $city_slug) {
        id
        name
        github_nickname
        official_avatar_url
        lecturer
        twitter_url
        bio_en
        bio_fr
      }
    }
  GRAPHQL
end
