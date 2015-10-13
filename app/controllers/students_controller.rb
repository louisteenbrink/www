class StudentsController < ApplicationController
  before_action :set_client

  def index
    @projects = @client.projects(Static::SITE[:featured][:alumni])
    @students = Static::STUDENTS
  end

  private

  def set_client
    @client = AlumniClient.new
  end
end
