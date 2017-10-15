class PushApplyJob < ActiveJob::Base
  def perform(apply_id)
    apply = Apply.find(apply_id)
    apply.fetch_linkedin_profile

    card = PushToTrelloRunner.new(apply).run
    PushStudentToCrmRunner.new(card, apply).run

    if Rails.env.production?
      SubscribeToNewsletter.new(apply.email).run

      city = Kitt::Client.query(City::Query, variables: { slug: @prospect.city }).data.city
      if city.mailchimp_list_id.present? && city.mailchimp_list_id.present?
        SubscribeToNewsletter.new(apply.email, list_id: city.mailchimp_list_id, api_key: city.mailchimp_api_key).run
      end
    end
  end
end
