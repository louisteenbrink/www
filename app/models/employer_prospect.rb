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
#  targets      :string
#  locations    :string
#  message      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class EmployerProspect < ApplicationRecord

  validates :first_name, :last_name, :phone_number, :company, :website, :targets, :locations, :message, presence: true
  validates :email, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :website, format: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\z/

  # targets and locations are arrays of strings
  serialize :targets
  serialize :locations

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def to_slack_message
"*Person:* #{full_name} - #{email} - #{phone_number}
*Company:* #{company}
*Company Website:* #{website}
*Why:* #{message}
*Which city:* #{self.locations.reject { |l| l.empty? }.join(", ")}
*Looking for:* #{self.targets.reject { |l| l.empty? }.join(", ")}"
  end
end
