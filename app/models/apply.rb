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
#  linkedin            :string
#

class Apply < ActiveRecord::Base
  MANDATORY_CODECADEMY_CITIES = %w(paris)

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :age, presence: true, numericality: { only_integer: true }
  validates :email, presence: true, email: true
  validates :motivation, presence: true, length: { minimum: 140 }

  attr_accessor :skip_source_validation
  validates :source, presence: { message: I18n.translate('applies.new.source_presence_message') }, unless: :skip_source_validation

  attr_accessor :validate_ruby_codecademy_completed
  validate :ruby_codecademy_completed, if: :validate_ruby_codecademy_completed

  attr_reader :linkedin_profile
  before_validation :fetch_linkedin_profile, unless: ->() { self.linkedin.blank? }
  validate :linkedin_url_exists, unless: ->() { self.linkedin.blank? }

  after_create :push_to_trello, if: :push_to_trello?

  def push_to_trello
    PushStudentJob.perform_later(id)
  end

  def tracked?
    tracked
  end

  def push_to_trello?
    batch_id && !Rails.env.test?
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

  def codecademy_progress
    return 0 if codecademy_username.blank?
    client = CodecademyCheckerClient.new
    result = client.ruby_progress(codecademy_username)
    result["percentage"]
  end

  def fetch_linkedin_profile
    return if @linkedin_profile

    require 'addressable/uri'
    uri = Addressable::URI.parse(linkedin)
    uri.query_values = nil
    self.linkedin = uri.to_s

    @linkedin_profile = LinkedinClient.new.fetch(linkedin)
  rescue Faraday::ResourceNotFound
    @linkedin_profile = nil
    errors.add :linkedin, "Sorry, this does not seem to be a valid Linkedin URL" # TODO: i18n
  rescue Faraday::ClientError => e
    if Rails.env.production?
      Raygun.track_exception(e)
    else
      raise e
    end
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

  def linkedin_url_exists
    !linkedin_profile.nil?
  end
end
