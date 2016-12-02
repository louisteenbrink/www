module DemodayHelper
  def format_date(serialized_date)
    I18n.localize(Time.parse(serialized_date), format: '%B').camelcase
  end

  def format_date_complete(serialized_date)
    I18n.localize(Time.parse(serialized_date), format: '%B %Y').camelcase
  end
end
