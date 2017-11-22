require "graphql/client"
require "graphql/client/http"

module Kitt
  HTTP = GraphQL::Client::HTTP.new("#{ENV['KITT_BASE_URL']}/graphql")
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
