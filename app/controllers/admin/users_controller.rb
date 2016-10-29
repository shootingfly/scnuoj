class Admin::UsersController < Admin::ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
        respond_to do |format|
            format.html
            format.json {render json: Admin::UserDatatable.new(view_context)}
        end
    end

    def show
        @user_detail = UserDetail.take
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash.notice = "User #{@user.username} was successfully created."
            redirect_to admin_new_user_path
        else
            render :new
        end
    end

    def edit
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
        @id = @user.id
        @user.destroy
        respond_to do |format|
            format.html {redirect_to admin_users_path}
            format.js
        end
    end

    private

    def set_user
        @user = User.find_by(student_id: params[:student_id])
    end

    def user_params
        params.require(:user).permit(:student_id, :username, :password, :classgrade, :dormitory, :phone, :signature)
    end
end
