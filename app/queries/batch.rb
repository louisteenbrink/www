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

  ApplyQuery = Kitt::Client.parse <<-'GRAPHQL'
    query {
      batches: apply_camps {
        id
        slug
        starts_at
        apply_status
        price_cents
        price_currency
        city {
          id
          slug
        }
      }
    }
  GRAPHQL
end

