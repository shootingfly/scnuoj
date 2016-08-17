class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout "application"


  # def current_user
  # 	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  # 	logger.debug("current_user = #{@current_user}")
  # end

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end
	
  def current_theme
    return cookies[:theme] || "yeti"
  end

  helper_method :current_user, :current_theme
end
