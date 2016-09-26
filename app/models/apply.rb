# == Schema Information
#
# Table name: applies
#
#  id                  :integer          not null, primary key
#  first_name          :string
#  last_name           :string
#  age                 :integer
#  email               :string
#  phone               :string
#  motivation          :text
#  batch_id            :integer
#  city_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  tracked             :boolean          default(FALSE), not null
#  source              :string
#  codecademy_username :string
#

class Apply < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :age, presence: true, numericality: { only_integer: true }
  validates :email, presence: true, email: true
  validates :motivation, presence: true, length: { minimum: 140 }
  validates :source, presence: { message: I18n.translate('applies.new.source_presence_message') }

  attr_accessor :validate_ruby_codecademy_completed
  validate :ruby_codecademy_completed, if: :validate_ruby_codecademy_completed

  after_create :push_to_trello, if: :push_to_trello?

  def push_to_trello
    card = PushToTrelloRunner.new(self).run

    if Rails.env.production?
      PushStudentToCrmRunner.new(card, self).run
      SubscribeToNewsletter.new(email).run

      city = AlumniClient.new.city(self.city_id)
      if city.mailchimp?
        SubscribeToNewsletter.new(email, list_id: city.mailchimp_list_id, api_key: city.mailchimp_api_key).run
      end
    end
  end

  def tracked?
    tracked
  end

  def push_to_trello?
    batch_id && !Rails.env.test? && !Rails.env.development?
  end

  def batch
    @batch ||= AlumniClient.new.batch(batch_id)
  end

  def to_drift
    city = AlumniClient.new.city(self.city_id)
    {
      email: email,
      first_name: first_name,
      last_name: last_name,
      age: age,
      phone: phone,
      city: city.name
    }.to_json
  end

  private

  def ruby_codecademy_completed
    client = CodecademyCheckerClient.new
    result = client.ruby_progress(codecademy_username)
    if result["error"]
      errors.add :codecademy_username, result["error"]["message"]
    elsif result["percentage"] < 100
      errors.add :codecademy_username, "You did #{result["percentage"]}% of the CodeCademy Ruby track. We need 100%."
    end
  end
end
