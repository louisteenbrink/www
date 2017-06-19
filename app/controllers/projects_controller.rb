class ProjectsController < ApplicationController
  def index
    if request.format.html? || params[:project_page]
      @projects = @kitt_client.new.products #("alumni_projects") TODO read alumni_projects list from a yml
      @projects = Kaminari.paginate_array(@projects).page(params[:project_page]).per(10)
    end
  end
end
