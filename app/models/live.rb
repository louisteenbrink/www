# == Schema Information
#
# Table name: lives
#
#  id          :integer          not null, primary key
#  category    :string
#  user_id     :integer
#  started_at  :datetime
#  ended_at    :datetime
#  url         :string
#  batch_slug  :string
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_lives_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_2e851e6dff  (user_id => users.id)
#

class Live < ApplicationRecord
  CATEGORIES = %w(demoday aperotalk)

  belongs_to :user, required: true

  validates :title, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :batch_slug, presence: true, if: ->() { self.category == 'demoday' }

  def self.running_now
    Live.where(ended_at: nil).where.not(started_at: nil).order(started_at: :desc).first
  end
end
