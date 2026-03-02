module Admin
  class DanceStylesController < BaseController
    before_action :set_dance_style, only: [:show, :edit, :update, :destroy]

    def index
      @dance_styles = DanceStyle.ordered.page(params[:page]).per(20)
    end

    def show
    end

    def new
      @dance_style = DanceStyle.new
    end

    def edit
    end

    def create
      @dance_style = DanceStyle.new(dance_style_params)

      if @dance_style.save
        log_operation('create', 'DanceStyle', @dance_style.id, "创建街舞分类: #{@dance_style.name}")
        redirect_to admin_dance_style_path(@dance_style), notice: '街舞分类创建成功'
      else
        render :new
      end
    end

    def update
      if @dance_style.update(dance_style_params)
        log_operation('update', 'DanceStyle', @dance_style.id, "更新街舞分类: #{@dance_style.name}")
        redirect_to admin_dance_style_path(@dance_style), notice: '街舞分类更新成功'
      else
        render :edit
      end
    end

    def destroy
      @dance_style.destroy
      log_operation('delete', 'DanceStyle', @dance_style.id, "删除街舞分类: #{@dance_style.name}")
      redirect_to admin_dance_styles_url, notice: '街舞分类删除成功'
    end

    def remove_uploaded_image
      @dance_style = DanceStyle.find(params[:id])
      @dance_style.uploaded_image.purge if @dance_style.uploaded_image.attached?
      log_operation('update', 'DanceStyle', @dance_style.id, "删除街舞分类图片: #{@dance_style.name}")
      redirect_to edit_admin_dance_style_path(@dance_style), notice: '图片已删除'
    end

    private

    def set_dance_style
      @dance_style = DanceStyle.find(params[:id])
    end

    def dance_style_params
      params.require(:dance_style).permit(:name, :description, :image, :uploaded_image)
    end
  end
end
