class Admin::ManagersController < Admin::ApplicationController
    
    before_action :set_manager, only: [:show, :edit, :update, :destroy]

    def index
        @page_title = 'Managers'
        respond_to do |format|
            format.html
            format.json {render json: Admin::ManagerDatatable.new(view_context)}
        end
    end

    def new
        @page_title = 'New Managers'
        @manager = Manager.new
    end

    def create
        @manager = Manager.new(manager_params)
        if @manager.save
            flash[:notice] = "添加#{@manager.username}成功!"
            redirect_to admin_managers_path
        else
            render :new
        end
    end

    def edit
        @page_title = 'Update Managers'
    end

    def update
        if @manager.update(manager_params)
            redirect_to admin_managers_path, notice: "update successful!"
        else
            render :edit
        end
    end

    def destroy
        flash[:notice] = "Delete #{@manager.username}成功!"
        @manager.destroy
        redirect_to admin_managers_path
    end

    private

    def set_manager
        @manager = Manager.find(params[:id])
    end

    def manager_params
        params.require(:manager).permit(:username, :password, :role, :remark)
    end
end
