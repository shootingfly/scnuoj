class Admin::UsersController < Admin::ApplicationController

    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
        respond_to do |format|
            format.html
            format.json {render json: Admin::UserDatatable.new(view_context)}
        end
    end

    def show
        @user_detail = @user.user_detail
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        @user.password_digest = BCrypt::Password.create(@user.student_id).to_s
        if @user.save
            flash.notice = "User #{@user.username} was successfully created."
            redirect_to new_admin_user_path
        else
            render :new
        end
    end

    def edit
        @page_title = "Edit User"
    end

    def update
        if @user.update(user_params)
            flash.notice = "User #{@user.username} was successfully updated"
            redirect_to admin_users_path
        else
            render :edit
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
    end

    def batch_create
        uploader = UsersUploader.new
        uploader.store!(params[:file])
        require "spreadsheet"
        user_xls = Spreadsheet.open("public/#{uploader.store_path}", "r")
        sheet = user_xls.worksheet 0
        sheet.each 1 do |row|
            User.create(
                student_id: row[0].to_i,
                username: row[1].to_s,
                classgrade: row[2].to_s,
                dormitory: row[3].to_s,
                phone: row[4].to_i,
                qq: row[5].to_i,
                password_digest: row[0].to_i,
                rank: 999,
                score: 0
            )
        end
        # uploader.remove!
        redirect_to admin_users_path
    end

    private

    DEFAULT_RANK = 9999
    DEFAULT_SCORE = 0

    def set_user
        @user = User.find_by(student_id: params[:id])
    end

    def user_params
        params.require(:user).permit(:student_id, :username, :password, :classgrade, :dormitory, :phone, :signature)
    end

end
