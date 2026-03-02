module Admin
  class AboutUsController < BaseController
    before_action :set_about_us, only: [:show, :edit, :update]

    def show
      redirect_to edit_admin_about_us_path
    end

    def edit
    end

    def update
      if @about_us.new_record?
        @about_us = AboutUs.new(about_us_params)
        if @about_us.save
          log_operation('create', 'AboutUs', @about_us.id, '创建关于我们信息')
          redirect_to edit_admin_about_us_path, notice: '关于我们信息创建成功'
        else
          render :edit
        end
      else
        if @about_us.update(about_us_params)
          log_operation('update', 'AboutUs', @about_us.id, '更新关于我们信息')
          redirect_to edit_admin_about_us_path, notice: '关于我们信息更新成功'
        else
          render :edit
        end
      end
    end

    def remove_uploaded_image
      @about_us = AboutUs.instance
      @about_us.uploaded_image.purge if @about_us.uploaded_image.attached?
      log_operation('update', 'AboutUs', @about_us.id, '删除关于我们图片')
      redirect_to edit_admin_about_us_path, notice: '图片已删除'
    end

    private

    def set_about_us
      @about_us = AboutUs.instance
    end

    def about_us_params
      params.require(:about_us).permit(:mission, :teaching_philosophy, :image, :uploaded_image)
    end
  end
end
