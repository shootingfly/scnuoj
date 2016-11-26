class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception

  layout "application"

  def current_user
    @current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  end
	
  def current_theme
    cookies[:theme] || "yeti"
  end

  def current_mode
    cookies[:mode] || "ruby"
  end

  def current_keymap
    cookies[:keymap] || "vim" 
  end

  def current_locale
    cookies[:locale] || 'en' 
  end

  helper_method :current_user, :current_theme, :current_locale, :current_mode, :current_keymap
end
