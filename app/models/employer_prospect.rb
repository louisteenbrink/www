# == Schema Information
#
# Table name: employer_prospects
#
#  id           :integer          not null, primary key
#  first_name   :string
#  last_name    :string
#  email        :string
#  phone_number :string
#  company      :string
#  website      :string
#  targets      :string           is an Array
#  locations    :string           is an Array
#  message      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class EmployerProspect < ApplicationRecord

  validates :first_name, :last_name, :phone_number, :company, :website, :targets, :locations, :message, presence: true
  validates :email, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :website, format: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\z/

  before_validation :sanitize_url

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def sanitize_url
    if website && !website.start_with?("http", "https")
      self.website = "https://" + self.website
    end
  end

end
