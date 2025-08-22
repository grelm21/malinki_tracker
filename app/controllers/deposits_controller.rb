class DepositsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_classrooms_student, only: %i[new]
  def new
    @deposit = Deposit.new
  end

  def create
    @deposit = Deposit.build(deposit_params)
    if @deposit.save!
      redirect_to @deposit.classrooms_student.student, notice: 'Депозит создан'
    else
      render :new
    end
  end

  private

  def deposit_params
    params.require(:deposit).permit(:amount, :classrooms_student_id, :issued_at)
  end

  def set_classrooms_student
    @classrooms_student = ClassroomsStudent.find_by(student_id: params[:student_id],
                                                    classroom_id: params[:classroom_id])
  end
end
