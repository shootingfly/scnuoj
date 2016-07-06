class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.new(user_params)
  	if @user.update
  		redirect_to oj_user_path
  	else
  		render :edit
  	end
  end

  private
  def user_params
  	params.require(:user).permit()
  end
end
