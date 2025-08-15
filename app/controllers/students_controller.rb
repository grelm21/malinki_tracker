class StudentsController < ApplicationController

  def new
    @student = Student.new
  end

  def show
    @student = Student.find(params[:id])
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to dashboard_path
    else
      render :new
    end
  end
  private

  def student_params
    params.require(:student).permit(:name, :contact_details)
  end
end
