module Admin
  class RolesController < BaseController
    def index
      @roles = Role.page(params[:page])
    end

    def show
      @role = Role.find(params[:id])
    end

    def new
      @role = Role.new
      @permissions = Permission.all
    end

    def create
      @role = Role.new(role_params)
      if @role.save
        if params[:permission_ids].present?
          @role.permission_ids = params[:permission_ids]
        end
        log_operation('create_role', 'Role', @role.id, "Created role: #{@role.name}")
        redirect_to admin_role_path(@role), notice: '角色创建成功'
      else
        @permissions = Permission.all
        render :new
      end
    end

    def edit
      @role = Role.find(params[:id])
      @permissions = Permission.all
    end

    def update
      @role = Role.find(params[:id])
      if @role.update(role_params)
        if params[:permission_ids].present?
          @role.permission_ids = params[:permission_ids]
        else
          @role.permission_ids = []
        end
        log_operation('update_role', 'Role', @role.id, "Updated role: #{@role.name}")
        redirect_to admin_role_path(@role), notice: '角色更新成功'
      else
        @permissions = Permission.all
        render :edit
      end
    end

    def destroy
      @role = Role.find(params[:id])
      @role.destroy
      log_operation('delete_role', 'Role', @role.id, "Deleted role: #{@role.name}")
      redirect_to admin_roles_path, notice: '角色删除成功'
    end

    private

    def role_params
      params.require(:role).permit(:name, :description, :is_active)
    end
  end
end
