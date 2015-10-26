class StudentsController < ApplicationController
  before_action :set_client

  def index
    @testimonials = @client.testimonials(locale.to_s)
    @projects = @client.projects("alumni_projects")
  end

  private

  def set_client
    @client = AlumniClient.new
  end
end
