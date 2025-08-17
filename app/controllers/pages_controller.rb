class PagesController < ApplicationController
  before_action :authenticate_user!
  def dashboard
    # @classrooms = Classroom.all
    @teacher = current_user.teacher
    @classrooms = @teacher.classrooms.all
  end
end
