class StaticPagesController < ApplicationController

  protect_from_forgery
  def home
  	@page_title = 'Home'
  end

  def aboutus
  	@page_title = 'About Us'
  end

  def set_theme
    cookies.permanent[:theme] = params[:theme]
    redirect_to :back
  end
end
