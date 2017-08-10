require 'roar/json/hal'
require 'roar/coercion'
require 'roar/json'

module UserRepresenter#Roar::Decorator
  include Roar::JSON::HAL
  include Roar::Hypermedia
  include Roar::Coercion
  include Roar::JSON

  property :id
  property :updated_at, type: DateTime
  property :github_nickname


  collection_representer class: Api::User
end

# UserRepresenter.for_collection.new([]).from_json(json)
