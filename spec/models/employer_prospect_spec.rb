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

require 'rails_helper'

RSpec.describe EmployerProspect, type: :model do

  let(:employer) { EmployerProspect.new(
    first_name: "George",
    last_name: "Abitbol",
    email: "lhomme_le_plus_class@dumonde.com",
    phone_number: "+33 6 12 34 56 78",
    company: "Yoji Yamamoto",
    website: "www.yojiyamamoto.com",
    targets: ["Product manager", "Front-end developer"],
    locations: ["Tokyo", "Berlin", "Paris"],
    message: "Tu confonds la classe et la coqueterie"
    ) }

  describe "validations" do
    it 'is valid with valid attributes' do
      expect(employer.valid?).to be true
    end

    it 'is not valid with if one attribute is missing' do
      employer.first_name = nil
      expect(employer.valid?).to be false
    end
  end

  describe "#full_name" do
    it 'returns the full name capitalized' do
      employer.first_name = "george"
      employer.last_name = "abitbol"
      expect(employer.full_name).to eq("George Abitbol")
    end
  end

  describe "#to_slack_message" do
    it 'returns a formated text' do
      message = employer.to_slack_message
      expect(message).to match(/George/)
      expect(message).to match(/\*Company\:\*/)
    end
  end
end
