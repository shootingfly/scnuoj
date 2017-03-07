class Admin::MainController < Admin::ApplicationController

    skip_before_action :require_login, only: [:login, :login_session, :logout]

    def login
        @page_title = "登录"
        render :login, layout: false
    end

    def login_session
        @manager = Manager.find_by(username: params[:username])
        if verify_rucaptcha?(@manager)
            redirect_to admin_root_path, notice: "验证码错误"
        elsif @manager && @manager.authenticate(params[:password])
            cookies[:auth_token] = @manager.auth_token
            redirect_to admin_home_path
        else
            redirect_to admin_root_path, notice: "用户名或密码错误"
        end
    end

    def logout
        cookies.delete(:auth_token)
        redirect_to admin_root_path
    end

    def about
    end

    def home
        @user_count = User.count
        @problem_count = Problem.count
    end

end
