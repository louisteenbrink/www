module Batch
  Query = Kitt::Client.parse <<-'GRAPHQL'
    query($slug: String, $id: ID) {
      batch: camp(slug: $slug, id: $id) {
        id
        slug
        starts_at
        ends_at
        meta_image_url
        cover_image_url
        demoday_youtube_id
        force_completed_codecademy_at_apply
        analytics_slug
        trello_inbox_list_id
        price
        city {
          id
          slug
          name
          locale
          city_background_picture_url
        }
      }
    }
  GRAPHQL

  CompletedQuery = Kitt::Client.parse <<-'GRAPHQL'
    query {
      batches: camps {
        id
        slug
        starts_at
        ends_at
        meta_image_url
        demoday_youtube_id
        city {
          id
          slug
          locale
          name
          city_background_picture_url
        }
      }
    }
  GRAPHQL
end

