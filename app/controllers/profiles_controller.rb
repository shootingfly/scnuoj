class ProfilesController < ApplicationController

	before_action :set_profile

	def edit
		@page_title = 'Profile'
		render template: "users/profile"
	end

	def update
		@profile.theme = cookies[:theme] = params[:theme]
		@profile.mode = cookies[:mode] = params[:mode]
		@profile.keymap = cookies[:keymap] =  params[:keymap]
		@profile.locale = cookies[:locale] = params[:locale]
		@profile.code_theme = cookies[:code_theme] = params[:code_theme]
		@profile.save
		redirect_to :back
	end

	private

	def set_profile
		@profile = current_user.profile
	end
end