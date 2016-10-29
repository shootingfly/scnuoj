class Admin::ManagersController < Admin::ApplicationController
    def index
        respond_to do |format|
            format.html
            format.json {render json: Admin::ManagerDatatable.new(view_context)}
        end
    end

    def new
        @manager = Manager.new
    end

    def create
        @manager = Manager.new(manager_params)
        if @manager.save
            flash.notice = "添加#{@manager.username}成功!"
            redirect_to admin_managers_path
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

    private
    def manager_params
        params.require(:manager).permit(:username, :password, :role, :remark)
    end
end
