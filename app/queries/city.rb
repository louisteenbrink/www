module City
  Query = Kitt::Client.parse <<-'GRAPHQL'
    query($slug: String!) {
      city(slug: $slug) {
        id
        name
        slug
        locale
        meetup_id
        contact_phone_number
        contact_phone_number_name
        contact_phone_number_displayed
        email
        address
        description_en
        description_fr
        marketing_specifics
        logistic_specifics
        location
        latitude
        longitude
        apply_facebook_pixel
        city_background_picture_url
        classroom_background_picture_url
        location_background_picture_url
        current_batch: current_camp {
          id
          slug
          teachers {
            id
            role
            lecturer
            bio_en
            bio_fr
            user {
              id
              github_nickname
              first_name
              last_name
              twitter_url
              avatar_url
            }
          }
        }
        next_batch: next_camp {
          id
          slug
          starts_at
        }
      }
    }
  GRAPHQL

  GroupsQuery = Kitt::Client.parse <<-'GRAPHQL'
    query {
      cities {
        id
        slug
        name
      }
    }
  GRAPHQL
end
