class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_date, only: %i[dashboard]
  before_action :move_date, only: %i[dashboard]

  def dashboard
    @teacher = current_user.teacher

    # TODO: перенести в отдельный сервис после дебага
    @classrooms = @teacher.classrooms.includes(:students).with_lesson_on_date(@date)
    @left_deposits = LeftDepositService.new(@classrooms).call

    @sum_for_day = @teacher.withdrawals.sum_for_day(@date)
    @sum_for_month = @teacher.withdrawals.sum_for_month(@date)
  end

  private

  def get_date
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def move_date
    return if params[:move].nil?

    @date = case params[:move]
            when 'yesterday'
              @date.yesterday
            when 'tomorrow'
              @date.tomorrow
            end
  end
end
