class Admin::ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    layout "admin"

    before_action :require_login

    def require_login
        redirect_to(admin_root_path, notice: "请先登录") unless cookies[:auth_token]
    end

    def current_theme
        cookies[:theme] || DEFAULT_THEME
    end

    def current_user
        @current_user ||= Manager.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
    end

    helper_method :current_theme, :current_user
end
