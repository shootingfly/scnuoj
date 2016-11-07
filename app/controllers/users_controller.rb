class UsersController < ApplicationController

  def show
    @user = User.find_by_student_id(params[:student_id])
    @user_detail = @user.user_detail
    @page_title = @user.username
  end

  def edit
    @user =  current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
