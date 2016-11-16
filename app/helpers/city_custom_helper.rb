module CityCustomHelper
  def post_price
    {
      montreal: t('montreal.post_price')
    }.stringify_keys
  end

  def course_language
    {
      montreal: t('montreal.course_language')
    }.stringify_keys
  end
end
