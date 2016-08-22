class Admin::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout "admin"

  def current_theme
    @theme = cookies[:theme] || "yeti"
  end
  
  helper_method :current_theme
end
