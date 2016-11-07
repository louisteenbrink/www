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

    def analytics_slug
      if @json['id'] == 68 # HEC Paris
        @json['analytics_slug'] + '-hec'
      else
        @json['analytics_slug']
      end
    end
  end
end
