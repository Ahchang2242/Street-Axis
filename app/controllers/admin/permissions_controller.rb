module Admin
  class PermissionsController < BaseController
    def index
      @permissions = Permission.order(:resource, :action).page(params[:page])
    end

    def show
      @permission = Permission.find(params[:id])
    end

    def new
      @permission = Permission.new
    end

    def create
      @permission = Permission.new(permission_params)
      if @permission.save
        log_operation('create_permission', 'Permission', @permission.id, "Created permission: #{@permission.name}")
        redirect_to admin_permission_path(@permission), notice: '权限创建成功'
      else
        render :new
      end
    end

    def edit
      @permission = Permission.find(params[:id])
    end

    def update
      @permission = Permission.find(params[:id])
      if @permission.update(permission_params)
        log_operation('update_permission', 'Permission', @permission.id, "Updated permission: #{@permission.name}")
        redirect_to admin_permission_path(@permission), notice: '权限更新成功'
      else
        render :edit
      end
    end

    def destroy
      @permission = Permission.find(params[:id])
      @permission.destroy
      log_operation('delete_permission', 'Permission', @permission.id, "Deleted permission: #{@permission.name}")
      redirect_to admin_permissions_path, notice: '权限删除成功'
    end

    private

    def permission_params
      params.require(:permission).permit(:name, :resource, :action, :description)
    end
  end
end
