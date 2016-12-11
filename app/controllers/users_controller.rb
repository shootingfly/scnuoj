class UsersController < ApplicationController

    before_action :set_user, only: [:edit, :update]

    def sollution
    end

    def show
        @user = User.find_by(student_id: params[:id])
        @page_title = @user.username
        @user_detail = @user.user_detail
    end

    def edit
        @page_title = 'Edit User'
    end

    def update
        if @user.update(user_params)
            redirect_to user_path(@user), notice: "Update Successfully"
        else
            render :edit
        end
    end

    def edit_password
        @page_title = 'Edit Password'
    end

    def update_password
        @user_login = current_user.user_login
        flash[:notice] =
            if @user_login.authenticate(params[:old_password]) == false
               "Error:  Wrong Old Password" 
            elsif params[:new_password] != params[:password_confirmation]
                "Error:  Confirm Your Password" 
            else
                @user_login.password = params[:new_password]
                if @user_login.save
                    "Success: Update password"
                else
                     "Error:  Wrong New Password"
                end
            end
        redirect_to edit_password_user_path
    end

    private

    def user_params
        params.require(:user).permit!
    end

    def set_user
        @user = current_user
    end

end
