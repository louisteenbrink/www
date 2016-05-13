class StudentsController < ApplicationController
  def index
    @testimonials = @client.testimonials(locale.to_s)
    @projects = @client.projects("alumni_projects")
    @statistics = @client.statistics
    @demo_day = ({
      fr: {
        video_id: '79SQFIIR0O8',
        date: '4 mars 2016',
        city: 'Paris',
        slug: 18
      },
      en: {
        video_id: 'bhZRwXjUBK8',
        date: 'April 1st, 2016',
        city: 'Amsterdam',
        slug: 20
      }
    })[I18n.locale]
  end
end
