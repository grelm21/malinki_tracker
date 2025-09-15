class ClassroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_classroom, only: %i[show update]
  before_action :set_student, only: %i[update]

  def show; end

  def update
    @classroom.update(classroom_params)

    if @classroom.save
      if set_student
        redirect_to student_path(@student)
      else
        redirect_to classroom_path
      end
    else
      flash[:error] = @classroom.errors.full_messages.join(', ')
      redirect_to student_path(@student)
    end
  end

  private

  def set_classroom
    @classroom = Classroom.find(params[:id])
  end

  def set_student
    return unless params[:student_id]

    @student = Student.find(params[:student_id])
  end

  def classroom_params
    params.require(:classroom).permit(:name, :wage, :class_format, :length, :status, schedule: [])
  end
end
