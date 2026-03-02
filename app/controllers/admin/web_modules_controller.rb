module Admin
  class WebModulesController < BaseController
    def index
      @web_modules = WebModule.page(params[:page])
    end

    def show
      @web_module = WebModule.find(params[:id])
    end

    def new
      @web_module = WebModule.new
    end

    def create
      @web_module = WebModule.new(web_module_params)
      if @web_module.save
        log_operation('create_module', 'WebModule', @web_module.id, "Created module: #{@web_module.name}")
        redirect_to admin_web_module_path(@web_module), notice: '模块创建成功'
      else
        render :new
      end
    end

    def edit
      @web_module = WebModule.find(params[:id])
    end

    def update
      @web_module = WebModule.find(params[:id])
      if @web_module.update(web_module_params)
        log_operation('update_module', 'WebModule', @web_module.id, "Updated module: #{@web_module.name}")
        redirect_to admin_web_module_path(@web_module), notice: '模块更新成功'
      else
        render :edit
      end
    end

    def destroy
      @web_module = WebModule.find(params[:id])
      @web_module.destroy
      log_operation('delete_module', 'WebModule', @web_module.id, "Deleted module: #{@web_module.name}")
      redirect_to admin_web_modules_path, notice: '模块删除成功'
    end

    def toggle
      @web_module = WebModule.find(params[:id])
      @web_module.toggle_active!
      log_operation('toggle_module', 'WebModule', @web_module.id, "Toggled module: #{@web_module.name} to #{@web_module.is_active}")
      redirect_back fallback_location: admin_web_modules_path, notice: '模块状态已更新'
    end

    private

    def web_module_params
      params.require(:web_module).permit(:name, :identifier, :description, :is_active, :position, :config => {})
    end
  end
end
