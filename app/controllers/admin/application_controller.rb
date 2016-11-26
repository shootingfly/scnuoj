class Admin::ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    layout "admin"

    # before_action :require_login

    private

    def require_login
        unless cookies[:authenticate]
            flash.notice = "Please login first"
            redirect_to admin_root_path
        end
    end

    def current_theme
        @theme = cookies[:theme] || "yeti"
    end

    def current_user
        @current_user ||= Manager.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
    end

    helper_method :current_theme, :current_user
end
