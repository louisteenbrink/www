class AlumniStory
  def initialize(json)
    @json = json
  end

  def post?
    true
  end

  def video?
    false
  end

  def layout
  end

  def author
    {
      fname: @json['alumni']['first_name'],
      lname: @json['alumni']['last_name'],
      picture: @json['alumni']['photo_path'],
      batch: @json['alumni']['slug'],
      city: @json['alumni']['city'],
    }
  end

  def company
    @json['company']
  end

  def labels
    %w(alumni story)
  end

  def pushed
    'true'
  end

  def slug
    @json['slug']
  end

  def date
    @date ||= Date.parse(@json['created_at'])
  end

  def title
    @json['title']['en']
  end

  def thumbnail
    @json['picture']
  end

  def description
    @json['summary']['en']
  end

  def content
    @json['description']['en']
  end

  def read_time
    if content.length > 0
      words_number = content.split(" ").count
      reading_time = (words_number / Blog::Post::AVERAGE_WORD_PER_MINUTES).ceil
      [reading_time, Blog::Post::DEFAULT_READING_TIME_IN_MINUTES].max
    else
      Blog::Post::DEFAULT_READING_TIME_IN_MINUTES
    end
  end
end