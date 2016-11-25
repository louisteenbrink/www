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

class Live < ApplicationRecord
end
