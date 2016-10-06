class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  def show
    @user_detail = @user.user_detail
    @page_title = @user.username
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def login
    @page_title = 'Login'
    @user = User.new
  end

  def create_login_session
    @user = User.find_by_student_id(params[:student_id])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = @user.auth_token
      else
        cookies[:auth_token] = @user.auth_token
      end
      @profile = Profile.find_by_user_id(@user.id)
      cookies[:theme] = @profile.theme
      cookies[:mode] = @profile.mode
      cookies[:keymap] = @profile.keymap
      redirect_to :back
    else
      render :login
    end
  end

  def logout
    cookies.delete(:auth_token)  
    redirect_to :back
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit!
  end
end
