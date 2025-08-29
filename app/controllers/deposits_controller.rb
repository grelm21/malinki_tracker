class DepositsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deposit, only: %i[update destroy]
  before_action :set_classrooms_student, only: %i[new]
  def new
    @deposit = Deposit.new
  end

  def create
    @deposit = Deposit.build(deposit_params)
    if @deposit.save
      redirect_to @deposit.classrooms_student.student, notice: 'Депозит создан'
    else
      flash[:error] = @deposit.errors.full_messages.to_sentence
      redirect_to student_path(@deposit.classrooms_student.student)
    end
  end

  def update
    @deposit.update(deposit_params)

    if @deposit.save
      redirect_to student_path(@deposit.classrooms_student.student)
    else
      redirect_to student_path(@deposit.classrooms_student.student), error: @deposit.errors.full_messages.to_sentence
    end
  end

  def destroy
    @deposit.destroy!
    redirect_to student_path(@deposit.classrooms_student.student)
  end

  private

  def set_deposit
    @deposit = Deposit.find(params[:id])
  end

  def deposit_params
    params.require(:deposit).permit(:amount, :classrooms_student_id, :issued_at)
  end

  def set_classrooms_student
    @classrooms_student = ClassroomsStudent.find_by(student_id: params[:student_id],
                                                    classroom_id: params[:classroom_id])
  end
end
