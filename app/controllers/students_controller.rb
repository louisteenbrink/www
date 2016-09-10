class StudentsController < ApplicationController
  def index
    @testimonials = @client.testimonials(locale.to_s)
    @projects = @client.projects("alumni_projects")
    @statistics = @client.statistics
    @stories = @client.stories
    @demo_day = ({
      fr: {
        video_id: 'tf_oIjOxS2I',
        date: '2 sept 2016',
        city: 'Paris',
        slug: 30,
        start: 0
      },
      en: {
        video_id: '83fw4h2vxCc',
        date: 'Sept 10th, 2016',
        city: 'London',
        slug: 36,
        start: 0
      }
    })[I18n.locale]
  end
end
