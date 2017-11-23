module City
  Query = Kitt::Client.parse <<-'GRAPHQL'
    query($slug: String, $id: ID) {
      city(slug: $slug, id: $id) {
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
        city_background_picture
        classroom_background_picture
        location_background_picture
        mailchimp_list_id
        mailchimp_api_key
        twitter_url
        apply_batches: apply_camps {
          id
          starts_at
        }
        current_batch: current_camp {
          id
          slug
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
        city_background_picture
      }
    }
  GRAPHQL

  ApplyQuery = Kitt::Client.parse <<-'GRAPHQL'
    query {
      cities {
        id
        name
        slug
        locale
        city_background_picture
        apply_facebook_pixel
        apply_batches: apply_camps {
          id
          starts_at
          ends_at
          apply_status
          price
        }
      }
    }
  GRAPHQL
end
