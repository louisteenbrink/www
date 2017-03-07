class ProjectsController < ApplicationController
  def index
    if request.format.html? || params[:project_page]
      @projects = @client.projects("alumni_projects")
      @projects = Kaminari.paginate_array(@projects).page(params[:project_page]).per(10)
    end
  end
end
