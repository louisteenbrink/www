# == Schema Information
#
# Table name: prospects
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  from_path  :string
#  city       :string
#  name       :string
#  origin     :string
#

class Prospect < ApplicationRecord
  mailkick_user
  has_many :messages, class_name: "Ahoy::Message", as: :user

  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "not an email" }
  after_create :notify_slack

  private

  def notify_slack
    count_prospect_for_today = Prospect.where("created_at >= ?", Date.today).count
    city_part = city.blank? ? nil : ", coming from *#{city.capitalize}*,"
    NotifySlack.perform_later({
      "channel": Rails.env.development? ? "test" : "incoming",
      "username": "www",
      "icon_url": "https://raw.githubusercontent.com/lewagon/mooc-images/master/slack_bot.png",
      "text": "Today's #{count_prospect_for_today}#{count_prospect_for_today.ordinal} prospect#{city_part} for the free Web Development Basics track on *#{from_path}*: #{email}"
    })
  end
end
