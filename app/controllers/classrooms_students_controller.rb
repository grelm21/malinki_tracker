class ClassroomsStudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_classrooms_student, only: %i[update]
  def update
    @classrooms_student.update(classrooms_student_params)

    if @classrooms_student.save
      redirect_to student_path(@classrooms_student.student)
    else
      flash[:error] = 'Ошибка обновления данных'
      redirect_to student_path(@classrooms_student.student)
    end
  end

  private

  def set_classrooms_student
    @classrooms_student = ClassroomsStudent.find(params[:id])
  end

  def classrooms_student_params
    params.require(:classrooms_student).permit(:payment_type)
  end
end
