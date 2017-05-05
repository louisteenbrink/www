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
      # picture: authors/cedric_menteau.jpg
      # bio: "After a couple of year working for the surf industry, Cedric, pioneer from batch #1, is now taking care of our global content. From Paris to the closest beach, he helps us tackle some underground marketing tasks and organise a new Code x Surf camp!"
      # company: Le Wagon
      # position: Content Manager
      # company_website: lewagon.com
      # twitter: cedricmenteau
      # instagram: lewagonparis
      # linkedin: cedricmenteau
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