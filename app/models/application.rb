class Application
  include ActiveModel::Model

  PROPERTIES = %i(first_name last_name age email phone motivation)

  PROPERTIES.each do |property|
    attr_accessor property
    validates property, presence: true
  end

  validates :age, numericality: { only_integer: true }
  validates :email, email: true

  validates :motivation, length: { minimum: 140 }
end
