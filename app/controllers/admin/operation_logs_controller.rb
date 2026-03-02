module Admin
  class OperationLogsController < BaseController
    def index
      @logs = OperationLog.order(created_at: :desc)
      
      if params[:action_type].present?
        @logs = @logs.by_action(params[:action_type])
      end
      
      if params[:user_id].present?
        @logs = @logs.by_user(params[:user_id])
      end
      
      if params[:start_date].present? && params[:end_date].present?
        @logs = @logs.by_date_range(params[:start_date], params[:end_date])
      end
      
      @logs = @logs.page(params[:page])
      
      @users = User.all
      @actions = OperationLog.distinct.pluck(:action).compact
    end

    def show
      @log = OperationLog.find(params[:id])
    end
  end
end
