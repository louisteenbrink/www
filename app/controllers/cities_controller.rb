class CitiesController < ApplicationController
  def show
    city_slug = params[:city]

    @top_bar_message = I18n.t('.top_bar_message')
    @top_bar_cta = I18n.t('.top_bar_cta')
    @top_bar_url = demoday_index_path

    if city_slug.downcase != city_slug
      redirect_to city_path(city: city_slug.downcase)
      return
    end

    @city = @kitt_client.city(city_slug)
    if I18n.locale == I18n.default_locale &&
        @city['course_locale'].to_sym != I18n.locale &&
        !session[:city_locale_already_forced] &&
        (request.env["HTTP_ACCEPT_LANGUAGE"] || "").split(",").first =~ /^#{Regexp.quote(@city['course_locale'])}/
      redirect_to city_path(city_slug, locale: @city['course_locale'])
      session[:city_locale_already_forced] = true
      return
    end

    @reviews = ReviewsCounter.new.review_count

    if request.format.html? || params[:testimonial_page]
      @testimonials = Testimonial.where(route: city_slug)
      if @testimonials.empty?
        @testimonials = Testimonial.where(route: Testimonial::DEFAULT_ROUTE)
      end
      @testimonials = Kaminari.paginate_array(@testimonials).page(params[:testimonial_page]).per(6)
    end
    lead_teachers_slugs = Static::LEAD_TEACHERS[city_slug.to_sym].nil? ? [] : Static::LEAD_TEACHERS[city_slug.to_sym]
    pedagogic_team = @kitt_client.teachers(city_slug)
    all_teachers = pedagogic_team["teachers"]
    lead_teachers = all_teachers
      .select { |teacher| lead_teachers_slugs.include?(teacher["github_nickname"]) }
      .sort_by { |teacher| lead_teachers_slugs.index(teacher["github_nickname"]) }
    teachers = all_teachers - lead_teachers
    @teachers = lead_teachers.concat(teachers)
    @assistants = pedagogic_team["assistants"]
    @staff = Static::STAFF[city_slug.to_sym]

    meetup_cli = MeetupApiClient.new(@city["meetup_id"])
    @meetup = { events: meetup_cli.meetup_events, infos: meetup_cli.meetup  }
    session[:city] = @city['slug']

    # Next batch
    batch_city = @cities.find { |city| city['slug'] == @city['slug'] && !city['batches'].empty? }
    if batch_city
      @next_batch = batch_city['batches'].find { |batch| !batch['full'] }
    end

  end
end
