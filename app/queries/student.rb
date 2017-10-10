module Student
  BatchQuery = Kitt::Client.parse <<-'GRAPHQL'
    query($batch_slug: String!) {
      students: camp_users(camp_slug: $batch_slug) {
        id
        name
        github_nickname
        official_photo_url
      }
    }
  GRAPHQL
end
