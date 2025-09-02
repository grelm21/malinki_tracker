class WithdrawalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_classrooms_student, only: %i[new]
  before_action :set_teacher, only: %i[new create create_collection]

  def new
    @withdrawal = @teacher.withdrawals.new
  end

  def create
    @withdrawal = @teacher.withdrawals.build(withdrawal_params)

    if @withdrawal.save
      redirect_to @withdrawal.classrooms_student.student, notice: 'Списание создано'
    else
      flash[:error] = @withdrawal.errors.full_messages.to_sentence
      redirect_to @withdrawal.classrooms_student.student
    end
  end

  def create_collection
    if withdrawal_collection_params.present?
      @withdrawals = @teacher.withdrawals.create(withdrawal_collection_params)
    else
      flash[:error] = 'Вы не выбрали ни одного ученика для списания'
    end
    redirect_to root_path(date: withdrawal_params[:issued_at])
  end

  def destroy
    @withdrawal = Withdrawal.find(params[:id])
    @withdrawal.destroy!
    redirect_to student_path(@withdrawal.classrooms_student.student)
  end

  private

  def withdrawal_params
    params.require(:withdrawal).permit(:amount, :issued_at, :classrooms_student_id, :deposit_id)
  end

  def withdrawal_collection_params
    return nil if params[:withdrawal][:classrooms_student_ids].blank?

    params[:withdrawal][:classrooms_student_ids].map do |cs_id|
      withdrawal_params.merge!(classrooms_student_id: cs_id)
    end
  end

  def set_classrooms_student
    @classrooms_student = ClassroomsStudent.find_by(student_id: params[:student_id],
                                                    classroom_id: params[:classroom_id])
  end

  def set_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end
end
