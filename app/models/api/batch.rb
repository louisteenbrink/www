module Api
  class Batch
    def initialize(json)
      @json = json
    end

    def id
      @json["id"]
    end

    def trello_inbox_list_id
      @json["trello_inbox_list_id"]
    end

    def price
      @price ||= Money.new(@json["price_cents"], @json["price_currency"])
    end
  end
end
