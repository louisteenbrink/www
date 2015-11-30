class MeetupApiClient
  EXPIRE = 300

  def initialize(meetup_id)
    @id = meetup_id
    @api = MeetupApi.new
  end

  def meetup_events
    return [] if @id.nil?
    $redis.cache("meetups:#{@id}", EXPIRE) do
      @api.events(group_id: @id)["results"].select { |m| m["status"] == "upcoming" }
    end
  rescue
    []
  end

  def meetup
    return {} if @id.nil?
    $redis.cache("meetup:#{@id}", EXPIRE) do
      @api.groups(group_id: @id)["results"].first
    end
  rescue
    {}
  end
end
