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
    redirect_to user_path
  else
    render :edit
  end
end

def login
end

def create_login_session
  user = User.find_by_student_id(params[:student_id])
  if user && user.authenticate(params[:password])
    if params[:remember_me]
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
    end
    redirect_to :root
  else
    redirect_to :login
  end
end

def logout
  cookies.delete(:auth_token)  
  redirect_to :root
end

private
def user_params
  params.require(:user).permit!
end
end
