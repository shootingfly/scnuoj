class UsersController < ApplicationController

    def sollution
    end

    def show
        @user = User.find_by_student_id(params[:student_id])
        @user_detail = @user.user_detail
        @page_title = @user.username
    end

    def edit
        @page_title = t('edit_user')
        @user =  current_user
    end

    def update
        @user = current_user
        if @user.update(user_params)
            redirect_to user_path(@user)
        else
            render :edit
        end
    end

    def edit_password
    end

    def update_password
        @user_login = current_user.user_login
        if !@user_login.authenticate(params[:old_password])
            @user_login.password = params[:new_password]
            @user_login.password = params[:password_confirmation]
            if @user_login.save
                flash[:notice] = "Update password Successfully"
                redirect_to :root
            else
                flash[:notice] = "Please type into correct new_password"
                render :edit_password
            end
        else
            flash[:notice] = "Please type into correct old_password"
            render :edit_password
        end
    end
    private

    def user_params
        params.require(:user).permit!
    end

end
