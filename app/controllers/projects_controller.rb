class ProjectsController < ApplicationController
  def index
    @top_bar_message = I18n.t('.top_bar_message')
    @top_bar_cta = I18n.t('.top_bar_cta')
    @top_bar_url = demoday_index_path

    if request.format.html? || params[:project_page]
      @projects = Static::PROJECTS[:top].map do |project_slug|
        Kitt::Client.query(Product::Query, variables: { slug: project_slug }).data.product
      end
      @projects = Kaminari.paginate_array(@projects).page(params[:project_page]).per(10)
    end
  end
end
