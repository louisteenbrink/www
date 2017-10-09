module Student
  BatchQuery = Kitt::Client.parse <<-'GRAPHQL'
    query($batch_slug: String!) {
      students: camp_users(camp_slug: $batch_slug) {
        id
        name
        github_nickname
        avatar_url
      }
    }
  GRAPHQL

  UserQuery = Kitt::Client.parse <<-'GRAPHQL'
    query($github_nickname: String!) {
      user: user(github_nickname: $github_nickname) {
        id
        github_nickname
        name
        avatar_url
        camp {
          slug
          city {
            name
          }
        }
      }
    }
  GRAPHQL
end
