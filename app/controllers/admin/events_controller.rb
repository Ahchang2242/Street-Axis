module Admin
  class EventsController < BaseController
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    def index
      @events = Event.page(params[:page]).per(20)
    end

    def show
    end

    def new
      @event = Event.new
    end

    def edit
    end

    def create
      @event = Event.new(event_params)

      if @event.save
        log_operation('create', 'Event', @event.id, "创建活动: #{@event.title}")
        redirect_to admin_event_path(@event), notice: '活动创建成功'
      else
        render :new
      end
    end

    def update
      if @event.update(event_params)
        log_operation('update', 'Event', @event.id, "更新活动: #{@event.title}")
        redirect_to admin_event_path(@event), notice: '活动更新成功'
      else
        render :edit
      end
    end

    def destroy
      @event.destroy
      log_operation('delete', 'Event', @event.id, "删除活动: #{@event.title}")
      redirect_to admin_events_url, notice: '活动删除成功'
    end

    def remove_uploaded_image
      @event = Event.find(params[:id])
      @event.uploaded_image.purge if @event.uploaded_image.attached?
      log_operation('update', 'Event', @event.id, "删除活动图片: #{@event.title}")
      redirect_to edit_admin_event_path(@event), notice: '图片已删除'
    end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :date, :description, :image, :uploaded_image)
    end
  end
end
