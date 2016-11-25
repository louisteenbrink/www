# == Schema Information
#
# Table name: lives
#
#  id         :integer          not null, primary key
#  category   :string
#  started_at :datetime
#  ended_at   :datetime
#  url        :string
#  batch_slug :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Live, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
