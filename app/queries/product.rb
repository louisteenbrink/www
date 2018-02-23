module Product
  Query = Kitt::Client.parse <<-'GRAPHQL'
    query($slug: String!) {
      product(slug: $slug) {
        id
        name
        slug
        url
        tagline
        cover_picture_url
        og_image_url
        demoday_timestamp
      }
    }
  GRAPHQL

  BatchQuery = Kitt::Client.parse <<-'GRAPHQL'
    query($batch_slug: String!) {
      products: camp_products(camp_slug: $batch_slug) {
        id
        name
        slug
        url
        tagline
        cover_picture_url
        og_image_url
        demoday_timestamp
        makers: users {
          id
          name
          official_avatar_url
          hide_public_profile
        }
      }
    }
  GRAPHQL
end
