module Admin
  class ContactInfosController < BaseController
    before_action :set_contact_info, only: [:show, :edit, :update]

    def show
      redirect_to edit_admin_contact_info_path
    end

    def edit
    end

    def update
      if @contact_info.new_record?
        @contact_info = ContactInfo.new(contact_info_params)
        if @contact_info.save
          log_operation('create', 'ContactInfo', @contact_info.id, '创建联系我们信息')
          redirect_to edit_admin_contact_info_path, notice: '联系我们信息创建成功'
        else
          render :edit
        end
      else
        if @contact_info.update(contact_info_params)
          log_operation('update', 'ContactInfo', @contact_info.id, '更新联系我们信息')
          redirect_to edit_admin_contact_info_path, notice: '联系我们信息更新成功'
        else
          render :edit
        end
      end
    end

    def remove_uploaded_image
      @contact_info = ContactInfo.instance
      @contact_info.uploaded_image.purge if @contact_info.uploaded_image.attached?
      log_operation('update', 'ContactInfo', @contact_info.id, '删除联系我们图片')
      redirect_to edit_admin_contact_info_path, notice: '图片已删除'
    end

    private

    def set_contact_info
      @contact_info = ContactInfo.instance
    end

    def contact_info_params
      params.require(:contact_info).permit(:address, :phone, :email, :business_hours, :image, :uploaded_image)
    end
  end
end
