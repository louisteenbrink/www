class StudentsController < ApplicationController
  def index
    @projects = Static::PROJECTS
    @students = Static::STUDENTS
  end
end
