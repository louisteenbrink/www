module Statistics
  Query = Kitt::Client.parse <<-'GRAPHQL'
    query {
      statistics {
        batch_count
        alumni_count
      }
    }
  GRAPHQL
end
