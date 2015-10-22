class StudentsController < ApplicationController
  before_action :set_client

  def index
    @testimonials = @client.testimonials(locale.to_s)
    @projects = @client.projects(Static::SITE[:featured][:alumni])
  end

  private

  def set_client
    @client = AlumniClient.new
  end
end
