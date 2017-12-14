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

require 'rails_helper'

RSpec.describe EmployerProspectsController, type: :controller do
  it "notifies Slack" do
    ActiveJob::Base.queue_adapter = :test
    params = {
      first_name: "Alan",
      last_name: "Turing",
      phone_number: "3456789",
      email: "alan@turing.com",
      company: "E Corp.",
      website: "www.ecorp.com",
      targets: ["FullStack Developer", "Product Manager"],
      locations: ["Tokyo", "Paris"],
      message: "Realllllyyyyyy long text of more"
    }
    post :create, params: { employer_prospect: params }
    expect(NotifySlack).to have_been_enqueued
  end
end
