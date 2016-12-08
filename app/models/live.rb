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

class Live < ApplicationRecord
  CATEGORIES = %w(demoday aperotalk)

  belongs_to :user, required: true

  has_attachment :meta_image

  with_options if: :demoday? do |live|
    live.validates :batch_slug, presence: true, uniqueness: true
  end

  with_options if: :aperotalk? do |live|
    live.validates :city_slug, presence: true
    live.validates :title, presence: true
    live.validates :description, length: { maximum: 300 }
    live.validates :category, presence: true, inclusion: { in: CATEGORIES }
    live.validates :batch_slug, presence: true, if: ->() { self.category == 'demoday' }
  end

  def demoday?
    category == 'demoday'
  end

  def aperotalk?
    category == 'aperotalk'
  end

  def self.running_now
    Live.where(ended_at: nil).where.not(started_at: nil).order(started_at: :desc).first
  end
end
