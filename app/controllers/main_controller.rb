class MainController < ApplicationController

    def home
        @page_title = 'Home'
    end

    def aboutus
        @page_title = 'About'
    end

    def login
        @page_title = 'Login'
    end

    def faq
        @page_title = 'FAQ'
    end

    def login_session
        @user_login = UserLogin.find_by(student_id: params[:student_id])
        if @user_login.nil?
            redirect_to login_path, notice: "Username Error"
        elsif @user_login.authenticate(params[:password]) == false
            redirect_to login_path, notice: "Password Error"
        else
            if params[:remember_me]
                cookies.permanent[:token] = @user_login.token
            else
                cookies[:token] = @user_login.token
            end
            read_profile
            redirect_to session[:return_to] || root_path
            session.delete(:return_to)
        end
    end

    def logout
        cookies.delete(:token)
        redirect_to :back, notice: "See U Tomorrow"
    end

    def set_theme
        cookies[:theme] = params[:theme]
        redirect_to :back
    end

    def set_mode
        cookies[:mode] = params[:language]
        cookies[:code_theme] = params[:code_theme]
        cookies[:keymap] = params[:keymap]
        redirect_to :back
    end

    def set_locale
        if cookies[:locale] == 'en'
            cookies[:locale] = 'zh'
        else
            cookies[:locale] = 'en'
        end
        I18n.locale = cookies[:locale]
        redirect_to :back
    end

    private

    def read_profile
        profile = current_user.profile
        cookies[:mode] = profile.mode
        cookies[:theme] = profile.theme
        cookies[:keymap] = profile.keymap
        cookies[:locale] = profile.locale
    end

end
