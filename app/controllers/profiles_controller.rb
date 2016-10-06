class ProfilesController < ApplicationController

	def edit
		@page_title = 'Profile'
		@profile = Profile.find_by(user_id: params[:id])
		render template: "users/profile"
	end

	def update
		@profile = Profile.find_by(user_id: params[:user_id])
		@profile.theme = cookies.permanent[:theme] = params[:theme]
		@profile.mode = cookies.permanent[:mode] = params[:mode]
		@profile.keymap = cookies.permanent[:keymap] =  params[:keymap]
		@profile.save
		redirect_to :back
	end
end