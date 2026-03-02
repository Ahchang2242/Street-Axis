module Admin
  class UsersController < BaseController
    def index
      @users = User.order(created_at: :desc).page(params[:page])
    end

    def show
      @user = User.find(params[:id])
    end

    def edit
      @user = User.find(params[:id])
      @roles = Role.where(is_active: true)
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        log_operation('update_user', 'User', @user.id, "Updated user: #{@user.username}")
        redirect_to admin_user_path(@user), notice: '用户更新成功'
      else
        @roles = Role.where(is_active: true)
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      log_operation('delete_user', 'User', @user.id, "Deleted user: #{@user.username}")
      redirect_to admin_users_path, notice: '用户删除成功'
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :role_id, :is_admin, :online_status)
    end
  end
end
