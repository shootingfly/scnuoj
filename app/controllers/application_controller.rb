class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception

  layout "application"

  def current_user
    @current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  end
	
  def current_theme
    return cookies[:theme] || "yeti"
  end

  def current_mode
    return cookies[:mode] 
  end

  helper_method :current_user, :current_theme
end
