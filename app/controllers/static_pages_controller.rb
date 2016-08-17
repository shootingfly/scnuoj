class StaticPagesController < ApplicationController

  protect_from_forgery
  def home
  end

  def aboutus
  end

  def set_theme
    cookies.permanent[:theme] = params[:theme]
    redirect_to :back
  end
end
