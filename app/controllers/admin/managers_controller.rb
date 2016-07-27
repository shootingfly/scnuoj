class Admin::ManagersController < Admin::ApplicationController
	def index
		@managers = Manager.all
	end

	def new
		@manager = Manager.new
	end

	def create
		@manager = Manager.new(manager_params)
		if @manager.save
			redirect_to admin_managers_path, notice: "添加#{@manager.username}成功!"
		else	
			render :new
		end
	end

	def edit
		@manager = Manager.find(params[:id])
	end

	def update
		@manager = Manager.find(params[:id])
		if @manager.update(manager_params)
			redirect_to admin_managers_path, notice: "update successful!"
		else
			render :edit
		end
	end

	def destroy
		@manager = Manager.find(params[:id])
		@manager.destroy
		redirect_to admin_managers_path
	end
	
	def login
		render :login, layout: false
	end

	def create_login_session
		manager = Manager.find_by_username(params[:username])
		if manager && manager.authenticate(params[:password])
			cookies[:auth_token] = manager.auth_token
			redirect_to :root
		else
			redirect_to '/admin/login'
		end
	end

	def logout
		cookies.delete[:auth_token]
		redirect_to :root
	end

	private
	def manager_params
		params.require(:manager).permit(:username, :password, :role, :remark) 
	end
end