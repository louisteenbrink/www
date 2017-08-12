module City
  Query = Kitt::Client.parse <<-'GRAPHQL'
    query($slug: String!) {
      city(slug: $slug) {
        name
        slug
        locale
        meetup_id
        contact_phone_number_displayed
        email
        marketing_specifics
        location
        latitude
        city_background_picture_url
        classroom_background_picture_url
        current_batch: current_camp {
          slug
          teachers {
            role
            lecturer
            user {
              github_nickname
            }
          }
        }
      }
    }
  GRAPHQL
end
