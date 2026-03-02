module Admin
  class WebContentsController < BaseController
    before_action :set_web_content, only: [:show, :edit, :update, :destroy, :toggle_publish, :preview]

    def index
      @web_contents = WebContent.ordered.page(params[:page]).per(20)
    end

    def show
    end

    def new
      @web_content = WebContent.new
    end

    def edit
    end

    def create
      @web_content = WebContent.new(web_content_params)
      @web_content.author = current_user

      if @web_content.save
        log_operation('create', 'WebContent', @web_content.id, "创建内容: #{@web_content.title}")
        redirect_to admin_web_content_path(@web_content), notice: 'Web内容创建成功'
      else
        render :new
      end
    end

    def update
      if @web_content.update(web_content_params)
        log_operation('update', 'WebContent', @web_content.id, "更新内容: #{@web_content.title}")
        redirect_to admin_web_content_path(@web_content), notice: 'Web内容更新成功'
      else
        render :edit
      end
    end

    def destroy
      @web_content.destroy
      log_operation('delete', 'WebContent', @web_content.id, "删除内容: #{@web_content.title}")
      redirect_to admin_web_contents_url, notice: 'Web内容删除成功'
    end

    def toggle_publish
      if @web_content.is_published?
        @web_content.unpublish!
        log_operation('unpublish', 'WebContent', @web_content.id, "取消发布: #{@web_content.title}")
      else
        @web_content.publish!
        log_operation('publish', 'WebContent', @web_content.id, "发布内容: #{@web_content.title}")
      end
      redirect_back(fallback_location: admin_web_contents_path, notice: '状态更新成功')
    end

    def preview
      render :preview, layout: 'application'
    end

    private

    def set_web_content
      @web_content = WebContent.find(params[:id])
    end

    def web_content_params
      params.require(:web_content).permit(:title, :slug, :content, :summary, :content_type, :is_published, :position, :meta_title, :meta_description, :meta_keywords)
    end
  end
end
