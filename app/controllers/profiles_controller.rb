class ProfilesController < ApplicationController

	def edit
		@page_title = 'Profile'
		@profile = Profile.find_by(user_id: current_user.user_id)
		render template: "users/profile"
	end

	def update
		@profile = Profile.find_by(user_id: current_user.user_id)
		@profile.theme = cookies.permanent[:theme] = params[:theme]
		@profile.mode = cookies.permanent[:mode] = params[:mode]
		@profile.keymap = cookies.permanent[:keymap] =  params[:keymap]
		@profile.save
		redirect_to :back
	end

	def update_theme
		if current_user
			@profile = Profile.find_by(user_id: current_user.user_id) 
			@profile.theme = cookies[:theme] =  params[:theme]
			@profile.save
		else
			cookies[:theme] = params[:theme]
		end
		redirect_to :back
	end
end