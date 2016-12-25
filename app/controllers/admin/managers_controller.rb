class Admin::ManagersController < Admin::ApplicationController
    
    before_action :set_manager, only: [:show, :edit, :update, :destroy]

    def index
        @page_title = '管理员列表'
        respond_to do |format|
            format.html
            format.json {render json: Admin::ManagerDatatable.new(view_context)}
        end
    end

    def new
        @page_title = '添加管理员'
        @manager = Manager.new
    end

    def create
        @manager = Manager.new(manager_params)
        if @manager.save
            redirect_to admin_managers_path, notice: "新增管理员#{@manager.username}!"
        else
            render :new
        end
    end

    def edit
        @page_title = '修改管理员'
    end

    def update
        if @manager.update(manager_params)
            redirect_to admin_managers_path, notice: "更新管理员#{@manager.username}!"
        else
            render :edit
        end
    end

    def destroy
        if @manager.destroy
            redirect_to admin_managers_path, notice: "删除 #{@manager.username} 成功!"
        else
            redirect_to admin_managers_path, notice: "删除失败"
        end
    end

    private

    def set_manager
        @manager = Manager.find(params[:id])
    end

    def manager_params
        params.require(:manager).permit(:username, :password, :role, :remark)
    end
end
