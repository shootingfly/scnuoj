class Admin::MainController < Admin::ApplicationController

    skip_before_action :require_login, only: [:login, :login_session, :logout]

    def login
        @page = 'login'
        @manager = Manager.new
    end

    def login_session
        @manager = Manager.find_by(username: params[:username])
        if !(verify_rucaptcha? @manager)
            flash.notice = "Captcha is error"
            redirect_to admin_root_path
        elsif @manager && @manager.authenticate(params[:password])
            cookies[:auth_token] = @manager.auth_token
            redirect_to admin_home_path
        else
            flash.notice = "Username or Password is error"
            redirect_to admin_root_path
        end
    end

    def logout
        cookies.delete[:auth_token]
        redirect_to admin_root_path
    end

    def aboutus
    end

    def home
    end

end
