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

def create_login_session
  user = User.find_by_studend_num(params[:student_num])
  if user && authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to root
  else
    render :login
  end
end

def logout
  session[:user_id] = nil
  redirect_to :root
end

private
def user_params
  params.require(:user).permit()
end
end
