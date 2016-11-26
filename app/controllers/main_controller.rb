class MainController < ApplicationController

    def home
        @page_title = t('home')
    end

    def aboutus
        @page_title = t('about')
    end

    def login
        @page_title = t('login')
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
            read_profile
            redirect_to session[:return_to] || root_path
            session.delete(:return_to)
        else
            flash[:notice] = "Please checkout your student_id and password."
            redirect_to :login
        end
    end

    def logout
        cookies.delete(:auth_token)
        redirect_to :back
    end

    def set_theme
        cookies[:theme] = params[:theme]
        redirect_to :back
    end

    def set_locale
        if cookies[:locale] == 'en'
            cookies[:locale] = 'zh'
        else
            cookies[:locale] = 'en'
        end
        redirect_to :back
    end

    private

    def read_profile
        profile = @user.profile
        cookies[:mode] = profile.mode
        cookies[:theme] = profile.theme
        cookies[:keymap] = profile.keymap
    end
    
end
