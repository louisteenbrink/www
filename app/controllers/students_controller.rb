class StudentsController < ApplicationController
  before_action :set_client

  def index
    @projects = @client.projects(Static::SITE[:featured][:alumni])
  end

  private

  def set_client
    @client = AlumniClient.new
  end
end
