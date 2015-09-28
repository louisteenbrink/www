class MeetupApiClient
  def initialize(meetup_id)
    @id = meetup_id
  end
  def meetup_events
    begin
      api = MeetupApi.new
      meetup_events = $redis.cache("meetups:#{@id}", 300) do
        meetup_events = api.events(group_id: @id)["results"].select { |m| m["status"] == "upcoming" }
        meetup_events.map do |event|
          event.extend DeepSymbolizable
          event.deep_symbolize { |key| key }
        end
      end
    rescue Exception => e
      meetup_events = []
      puts e
    end
    return meetup_events
  end
  def meetup
    begin
      api = MeetupApi.new
      meetup = $redis.cache("meetup:#{@id}", 300) do
        meetup = api.groups(group_id: @id)["results"].first
        meetup.extend DeepSymbolizable
        meetup.deep_symbolize { |key| key }
      end
    rescue Exception => e
      meetup = nil
      puts e
    end
    return meetup
  end
end
