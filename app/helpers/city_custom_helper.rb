module CityCustomHelper
  def post_price
    early_bird_fr = "early bird (<strike><em>5500 €</em></strike>)".html_safe
    {
      montreal: t('montreal.post_price'),
      "aix-marseille": early_bird_fr,
      "bordeaux": early_bird_fr,
      "nantes": early_bird_fr,
      "london": "early bird (<strike><em>£7,000</em></strike>)".html_safe
    }.stringify_keys
  end

  def course_language
    {
      # montreal: t('montreal.course_language'),
      shanghai: t('shanghai.course_language'),
      chengdu: t('chengdu.course_language'),
      london: "English (Full-Time)", # Needed for PCDL / interest free lonas from the government.
    }.stringify_keys
  end
end
