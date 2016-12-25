class Admin::UsersController < Admin::ApplicationController

    before_action :set_user, only: [:edit, :update, :destroy]

    def index
        @page_title = '用户列表'
        respond_to do |format|
            format.html
            format.json {render json: Admin::UserDatatable.new(view_context)}
        end
    end

    def new
        @page_title = '添加用户'
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to new_admin_user_path, notice: "新增用户#{@user.username}"
        else
            render 'new'
        end
    end

    def edit
        @page_title = "修改用户"
    end

    def update
        if @user.update(user_params)
            redirect_to admin_users_path, notice: "更新用户#{@user.username}"
        else
            render 'edit'
        end
    end

    def destroy
        @user.destroy
        respond_to do |format|
            format.html {redirect_to admin_users_path}
            format.js {@id = params[:id]}
        end
    end

    def batch_new
        @page_title = '批量添加用户'
    end

    def batch_create
        uploader = UsersUploader.new
        uploader.store!(params[:file])
        require "spreadsheet"
        xls = Spreadsheet.open("#{Rails.public_path}/#{uploader.store_path}", "r")
        sheet = xls.worksheet(0)
        count = 0
        sheet.each(1) do |row|
            User.create(
                student_id: row[0].to_i,
                username: row[1].to_s,
                classgrade: row[2].to_s,
                dormitory: row[3].to_s,
                phone: row[4].to_i,
                qq: row[5].to_i,
            )
            count += 1
        end
        # uploader.remove!
        redirect_to admin_users_path, notice: "批量添加#{count}个用户"
    end

    private

    def set_user
        @user = User.find_by(student_id: params[:id])
    end

    def user_params
        params.require(:user).permit(:student_id, :username, :password, :classgrade, :dormitory, :phone, :signature, :qq)
    end

end
