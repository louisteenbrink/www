require 'roar/json/hal'
require 'roar/coercion'

module BatchRepresenter
  include Roar::JSON::HAL
  include Roar::Hypermedia
  include Roar::Coercion

  property :id
  property :updated_at, type: DateTime
  property :slug
  property :starts_at
  property :ends_at
  property :apply_status
  property :price_cents
  property :price_currency
  property :trello_inbox_list_id
  property :demoday_youtube_id
  property :force_completed_codecademy_at_apply
  property :cover_image
  property :analytics_slug
  nested :meta_image do
    property :meta_image, as: :facebook
  end

  link :self
end
