class PagesController < ApplicationController
  before_action :authenticate_user!
  def dashboard
    @teacher = current_user.teacher

    # TODO: перенести в отдельный сервис после дебага
    @classrooms = @teacher.classrooms.includes(:students)
    @left_deposits = LeftDepositService.new(@classrooms).call
  end
end
