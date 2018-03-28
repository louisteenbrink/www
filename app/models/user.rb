class User < ApplicationRecord
  devise :trackable
  devise :timeoutable
  devise :omniauthable, omniauth_providers: [ :kitt ]

  validates :kitt_id, presence: true, uniqueness: true

  def self.find_for_kitt_oauth(auth)
    return nil if !auth.info.admin && auth.info.cities.blank?

    user = where(kitt_id: auth.uid).first
    user = User.new(kitt_id: auth.uid) unless user
    user.github_nickname = auth.info.github_nickname
    user.email = auth.info.email
    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    user.gravatar_url = auth.info.avatar_url
    user.admin = auth.info.admin
    user.cities = auth.info.cities
    user.save!
    user
  end
end
