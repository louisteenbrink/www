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
