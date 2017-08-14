module Project
  Query = Kitt::Client.parse <<-'GRAPHQL'
    query($slug: String!) {
      project: product(slug: $slug) {
        id
        slug
        name
        tagline
        cover_picture_url
      }
    }
  GRAPHQL
end
