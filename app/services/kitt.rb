require "graphql/client"
require "graphql/client/http"

module Kitt
  base_url = ENV.fetch('KITT_BASE_URL', 'https://kitt.lewagon.com/graphql')
  HTTP = GraphQL::Client::HTTP.new(base_url)
  Schema = GraphQL::Client.load_schema(HTTP)
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end

  # def products(slugs = [])
  #   if slugs.empty?
  #     url = "#{@base_url}/products"
  #   else
  #     slugs_query = slugs.to_query('slugs')
  #     url = "#{@base_url}/products?#{slugs_query}"
  #   end
  #   from_cache(:projects, slugs.join(',')) do
  #     get(url)["products"]
  #   end
  # end

  # def batch(slug)
  #   Api::Batch.new get("#{@base_url}/camps/#{slug}")
  # end

  # def batches(filter = "all")
  #   if filter == 'completed'
  #     get("#{@base_url}/camps/completed")["batches"].map { |json| Api::Batch.new(json) }
  #   end
  # end

  # def teachers(city_slug)
  #   #TODO how to invalidate this cache?
  #   from_cache(:teachers, city_slug) do
  #     get("#{@base_url}/cities/#{city_slug}/teachers")["team"]
  #   end
  # end




