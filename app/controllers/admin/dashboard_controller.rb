module Admin
  class DashboardController < BaseController
    def index
      @total_users = User.count
      @active_users = User.where('last_sign_in_at > ?', 7.days.ago).count
      @online_users = User.where(online_status: 'online').count
      @total_modules = WebModule.count
      @active_modules = WebModule.where(is_active: true).count
      
      @user_growth = User.group_by_day(:created_at).count
      @module_usage = WebModule.order(usage_count: :desc).limit(10).pluck(:name, :usage_count)
      
      @recent_logs = OperationLog.order(created_at: :desc).limit(10)
    end
  end
end
