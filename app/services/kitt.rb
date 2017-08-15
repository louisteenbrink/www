require "graphql/client"
require "graphql/client/http"

module Kitt
  base_url = ENV.fetch('KITT_BASE_URL', 'https://kitt.lewagon.com') + "/graphql"
  HTTP = GraphQL::Client::HTTP.new(base_url)
  Schema = GraphQL::Client.load_schema(HTTP)
  class Client
    include Singleton
    include Cache
    DEFAULT_EXPIRE = 1.day

    class Error < StandardError
      def initialize(errors)
        @errors = errors
      end

      def to_s
        "#{@errors.messages.to_hash}, #{@errors.details.to_hash}"
      end
    end

    class << self
      delegate :query, to: :instance
      delegate :parse, to: :instance
    end

    def initialize
      @client = GraphQL::Client.new(schema: Schema, execute: HTTP)
    end

    delegate :parse, to: :@client

    def query(definition, variables: {}, context: {})
      result = from_cache(definition.document.to_query_string, variables, expire: DEFAULT_EXPIRE) do
        Rails.logger.debug "GRAPHQL QUERY: #{definition.document.to_query_string} (VARIABLES: #{variables})"
        response = @client.query(definition, variables: variables, context: context)
        raise Error.new(response.errors) if response.errors.messages.any?
        response.original_hash
      end
      data, extensions = result.values_at("data", "extensions")
      GraphQL::Client::Response.new(result, data: definition.new(data), extensions: extensions)
    end
  end
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




