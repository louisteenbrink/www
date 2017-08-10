require 'roar/json/hal'
require 'roar/coercion'

module CityRepresenter
  include Roar::JSON::HAL
  include Roar::Hypermedia
  include Roar::Coercion

  property :id
  property :updated_at, type: DateTime
  property :slug
  property :name

  link :self
end
