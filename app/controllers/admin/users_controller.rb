class Admin::UsersController < Admin::ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
		respond_to do |format|
			format.html
			format.json {render json: Admin::UserDatatable.new(view_context)}
		end
	end

	def show
	end

	def new
		@user = User.new
	end

	def edit
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.create_user_detail(user: @user)
			@user.create_profile({user: @user, theme: 'cosmo', mode: 'ruby', keymap: 'sublime'});
			redirect_to new_admin_user_path, notice: 'User was successfully created.' 
		else
			render :new
		end
	end

	def update
		if @user.update(user_params)
			redirect_to admin_users_path, notice: 'User was successfully updated.' 
		else
			render :edit
		end
	end

	def destroy
		@user.destroy
		respond_to do |format|
			format.html {redirect_to admin_users_path, notice: 'User was successfully destroyed.'}
			format.js
		end
	end

	private
		def set_user
			@user = User.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def user_params
			params.require(:user).permit(:student_id, :username, :password, :classgrade, :dormitory, :phone, :signature)
		end
end
