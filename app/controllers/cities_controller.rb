class CitiesController < ApplicationController
  def show
    if params[:city].downcase != params[:city]
      redirect_to city_path(city: params[:city].downcase)
      return
    end

    @city = @client.city(params[:city])
    if I18n.locale == I18n.default_locale &&
        @city['course_locale'].to_sym != I18n.locale &&
        !session[:city_locale_already_forced] &&
        (request.env["HTTP_ACCEPT_LANGUAGE"] || "").split(",").first =~ /^#{Regexp.quote(@city['course_locale'])}/
      redirect_to city_path(params[:city], locale: @city['course_locale'])
      session[:city_locale_already_forced] = true
      return
    end

    @testimonials = Testimonial.where(route: params[:city])
    if @testimonials.empty?
      @testimonials = Testimonial.where(route: Testimonial::DEFAULT_ROUTE)
    end

    @teachers = @client.staff(params[:city])["teachers"]
    @assistants = @client.staff(params[:city])["teacher_assistants"]

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
