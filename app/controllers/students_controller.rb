class StudentsController < ApplicationController
  def index
    @testimonials = @client.testimonials(locale.to_s)
    @projects = @client.projects("alumni_projects")
    @statistics = @client.statistics
    @demo_day = ({
      fr: {
        video_id: 'pRUVEoYr6bA',
        date: '3 juin 2016',
        city: 'Paris',
        slug: 24,
        start: 56
      },
      en: {
        video_id: '6ebCdcUAYVE',
        date: 'April 1st, 2016',
        city: 'Amsterdam',
        slug: 20,
        start: 0
      }
    })[I18n.locale]
  end
end
