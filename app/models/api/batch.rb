module Api
  class Batch
    def initialize(json)
      @json = json
    end

    def price
      @price ||= Money.new(@json["price_cents"], @json["price_currency"])
    end

    def method_missing(name)
      @json[name.to_s]
    end

    def as_json(options = {})
      @json
    end
  end
end
