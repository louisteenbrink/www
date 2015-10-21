class MeetupApiClient
  EXPIRE = 300

  def initialize(meetup_id)
    @id = meetup_id
    @api = MeetupApi.new
  end

  def meetup_events
    $redis.cache("meetups:#{@id}", EXPIRE) do
      @api.events(group_id: @id)["results"].select { |m| m["status"] == "upcoming" }
    end
  end

  def meetup
    $redis.cache("meetup:#{@id}", EXPIRE) do
      api.groups(group_id: @id)["results"].first
    end
  end
end
