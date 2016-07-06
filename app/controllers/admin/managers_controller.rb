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
			redirect_to new_admin_manager_path, notice: "添加#{@manager.manager_name}成功!"
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
			redirect_to managers_path, notice: "update successful!"
		else
			render :edit
		end
	end

	def destroy
		@manager = Manager.find(params[:id])
		@manager.destroy
		redirect_to managers_path
	end
	
	private
	def manager_params
		params.require(:manager).permit(:username, :password, :role, :remark) 
	end
end