class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher, only: %i[new create]

  def new
    @student = @teacher.students.new
  end

  def show
    @student = Student.find(params[:id])

    # student_policy
    @classrooms = @student.classrooms.where(teacher: current_user.teacher)

    @left_deposits = LeftDepositService.new(@classrooms).call
  end

  def create
    @student = Student.new(student_params)
    @student.teachers << @teacher
    if @student.save!
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :contact_details, :classroom_id, :wage, :length, :schedule, :payment_type)
  end

  def set_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end
end
