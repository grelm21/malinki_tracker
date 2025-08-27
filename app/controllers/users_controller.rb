class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role
  before_action :set_user, only: %i[update destroy]

  def index
    @users = User.with_teachers
  end

  def update
    @user.update(user_params)

    if @user.save
      redirect_to users_path
    else
      redirect_to users_path, alert: 'Не удалось подтвердить пользователя'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:approved)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_admin_role
    return if current_user.has_role?(:admin)

    redirect_to root_path, alert: 'Вы не имеете права доступа к этой странице'
  end
end
