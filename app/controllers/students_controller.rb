class StudentsController < ApplicationController
  def index
    @testimonials = @client.testimonials(locale.to_s)
    @projects = @client.projects("alumni_projects")
  end
end
