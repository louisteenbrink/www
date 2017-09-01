module Teacher
  BatchQuery = Kitt::Client.parse <<-'GRAPHQL'
    query($batch_slug: String!) {
      teachers: camp_teachers(camp_slug: $batch_slug) {
        id
        name
        github_nickname
        avatar_url
        role
        lecturer
        twitter_url
        bio_en
        bio_fr
      }
    }
  GRAPHQL
end
