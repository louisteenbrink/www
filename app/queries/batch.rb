module Batch
  Query = Kitt::Client.parse <<-'GRAPHQL'
    query($slug: String!) {
      batch: camp(slug: $slug) {
        id
        slug
        meta_image_url
      }
    }
  GRAPHQL
end

