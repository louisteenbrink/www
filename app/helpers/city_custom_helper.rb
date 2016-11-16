module CityCustomHelper
  def post_price
    {
      montreal: t('montreal.post_price')
    }.stringify_keys
  end
end
