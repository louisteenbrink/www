# == Schema Information
#
# Table name: lives
#
#  id           :integer          not null, primary key
#  category     :string
#  user_id      :integer
#  started_at   :datetime
#  ended_at     :datetime
#  batch_slug   :string
#  title        :string
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  city_slug    :string
#  subtitle     :string
#  link         :string
#  facebook_url :string
#
# Indexes
#
#  index_lives_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_2e851e6dff  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Live, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
