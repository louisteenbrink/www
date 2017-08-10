require 'roar/client'
require 'roar/json'

class Api::Record < OpenStruct
  include Roar::JSON
  include Roar::Client
end
