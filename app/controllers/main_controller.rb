class MainController < ApplicationController
    def home
    end

    def aboutus
    end

    def login
        @user = User.new
    end

    def login_session
        @user = User.find_by(student_id: params[:student_id])
        if @user && @user.authenticate(params[:password])
            if params[:remember_me]
                cookies.permanent[:auth_token] = @user.auth_token
            else
                cookies[:auth_token] = @user.auth_token
            end
            read_profile @user.id
            redirect_to :back
        else
            flash.notice = "Password"
            render :login
        end
    end

    def logout
        cookies.delete[:auth_token]
        redirect_to :back
    end

    private

    def read_profile user_id
        profile = Profile.find_by(user_id: user_id)
        cookies[:mode] = profile.mode
        cookies[:theme] = profile.theme
        cookies[:keymap] = profile.keymap
    end
end
