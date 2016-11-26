class ProfilesController < ApplicationController

	before_action :set_profile

	def edit
		@page_title = 'profile'
		@profile = current_user.profile
		render template: "users/profile"
	end

	def update
		@profile.update(profile_params)
		cookies[:theme] = params[:theme]
		cookies[:mode] = params[:mode]
		cookies[:keymap] =  params[:keymap]
		redirect_to :back
	end

	private

	def profile_params
		params.require(:profile).permit(:user_id, :theme, :mode, :keymap)
	end

	def set_profile
		@profile = current_user.profile
	end
end