class WithdrawalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_classrooms_student, only: %i[new]
  before_action :set_teacher, only: %i[new create]

  def new
    @withdrawal = @teacher.withdrawals.new
  end

  def create
    @withdrawal = @teacher.withdrawals.build(withdrawal_params)
    if @withdrawal.save
      redirect_to root_path
    else
      render :new
    end
  end

  def create_collection
  end

  private

  def withdrawal_params
    params.require(:withdrawal).permit(:amount, :classrooms_student_id, :issued_at)
  end

  def set_classrooms_student
    @classrooms_student = ClassroomsStudent.find_by(student_id: params[:student_id],
                                                    classroom_id: params[:classroom_id])
  end

  def set_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end
end
