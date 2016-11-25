# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :inet
#  last_sign_in_ip    :inet
#  uid                :string
#  github_nickname    :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable
  devise :omniauthable, omniauth_providers: [ :github ]

  def self.find_for_github_oauth(auth)
    user = where(uid: auth[:uid]).first || where(github_nickname: auth.info.nickname).first
    return nil if user.nil?
    user.uid = auth.uid
    user.github_nickname = auth.info.nickname
    user.save
    user
  end
end
