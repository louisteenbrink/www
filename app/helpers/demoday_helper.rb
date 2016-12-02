module DemodayHelper
  def format_date(serialized_date)
    I18n.localize(Time.parse(serialized_date), format: '%B').camelcase
  end
end
