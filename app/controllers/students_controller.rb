class StudentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @student = Student.new
  end

  def show
    @student = current_user.students.find(params[:id])
  end

  def create
    @student = current_user.students.new(student_params)
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
end
