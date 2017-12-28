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
  MININUM_MOTIVATION_LENGTH = 140

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :age, presence: true, numericality: { only_integer: true }
  validates :email, presence: true, email: true
  validate :email_is_valid_with_mailgun, unless: ->() { email.blank? }
  validates :motivation, presence: true, length: { minimum: 140 }

  attr_accessor :skip_source_validation
  validates :source, presence: { message: I18n.translate('applies.new.source_presence_message') }, unless: :skip_source_validation

  before_validation :strip_codecademy_username
  attr_accessor :validate_ruby_codecademy_completed
  validate :codecademy_username_exists, if: ->() { codecademy_username.present? }
  validates :codecademy_username, presence: true, if: :validate_ruby_codecademy_completed
  validate :ruby_codecademy_completed, if: :validate_ruby_codecademy_completed

  attr_reader :linkedin_profile
  before_validation :strip_linkedin
  before_validation :fetch_linkedin_profile
  validate :linkedin_url_exists, unless: ->() { self.linkedin.blank? }

  after_commit :push_to_services, on: :create, if: :push_to_services?

  def push_to_services
    PushApplyJob.perform_later(id)
  end

  def push_to_services?
    # TODO(alex): add back production condition
    batch_id # && Rails.env.production?
  end

  def tracked?
    tracked
  end

  def batch
    @batch ||= Kitt::Client.query(Batch::Query, variables: { id: batch_id }).data.batch
  end

  def city
    @city ||= Kitt::Client.query(City::Query, variables: { id: city_id }).data.city
  end

  def to_drift
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

  class LinkedinError < StandardError; end

  def fetch_linkedin_profile
    return if @linkedin_profile || linkedin.blank?

    unless linkedin =~ /linkedin\.com\/in/
      fail Faraday::ResourceNotFound, nil
    end

    require 'addressable/uri'
    uri = Addressable::URI.parse(linkedin)
    uri.query_values = nil
    self.linkedin = uri.to_s

    @linkedin_profile = LinkedinClient.new.fetch(linkedin)
  rescue Faraday::ResourceNotFound
    @linkedin_profile = nil
    errors.add :linkedin, "Sorry, this does not seem to be a <a href='https://www.linkedin.com/help/linkedin/answer/49315/finding-your-linkedin-public-profile-url?lang=en' target='_blank'>valid Linkedin URL</a>." # TODO: i18n
  rescue Faraday::ClientError => e
    puts "Apply #{id}: could not fetch Linkedin profile: #{linkedin}" + e.message
  end

  private

  def ruby_codecademy_completed
    return if codecademy_username.blank?

    client = CodecademyCheckerClient.new
    result = client.ruby_progress(codecademy_username)
    if result["error"]
      errors.add :codecademy_username, result["error"]["message"]
    elsif result["percentage"] < 100
      errors.add :codecademy_username, "You did #{result["percentage"]}% of the CodeCademy Ruby track. We need 100%."
    end
  end

  def codecademy_username_exists
    client = CodecademyCheckerClient.new
    result = client.ruby_progress(codecademy_username)
    if result["error"] && (
      result["error"]["type"] == "Codeacademy::User::UnknownUserError" ||
      result["error"]["message"] =~ /is not a codecademy username/i)
      errors.add(:codecademy_username, "This is not a valid Codecademy username. Please check it at <a href='https://www.codecademy.com/account' target='_blank'>codecademy.com/account</a>")
    end
  end

  def linkedin_url_exists
    !linkedin_profile.nil?
  end

  def strip_linkedin
    unless linkedin.blank?
      self.linkedin = URI.unescape(linkedin).gsub(/[^0-9A-zÀ-ÿ:\/\.-]/, '')
    end
  end

  def strip_codecademy_username
    unless codecademy_username.blank?
      self.codecademy_username = codecademy_username.gsub(/^.*\.com\/([^\/]+\/)?/, "")
    end
  end

  def email_is_valid_with_mailgun
    validation = Mailgun.new.validate_email(email)
    unless validation["is_valid"]
      if validation["did_you_mean"]
        message = "Oh oh. Did you mean #{validation["did_you_mean"]}?"
      else
        message = "Are you sure this is a valid email address?"
      end
      errors.add(:email, message)
    end
  end
end
