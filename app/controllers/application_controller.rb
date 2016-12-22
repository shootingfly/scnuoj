class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    layout "application"

    def current_user
        @current_user ||= UserLogin.find_by(token: cookies[:token]).user if cookies[:token]
    end

    def current_theme
        cookies[:theme] || DEFAULT_THEME
    end

    def current_mode
        cookies[:mode] || DEFAULT_MODE
    end

    def current_keymap
        cookies[:keymap] || DEFAULT_KEYMAP
    end

    def current_locale
        cookies[:locale] || DEFAULT_LOCALE
    end

    def current_code_theme
        cookies[:code_theme] || DEFAULT_CODE_THEME
    end

    helper_method :current_user, :current_theme, :current_locale, :current_mode, :current_keymap, :current_code_theme
end
