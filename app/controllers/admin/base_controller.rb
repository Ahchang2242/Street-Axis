module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!

    layout 'admin'

    private

    def authorize_admin!
      unless current_user&.is_admin? || (current_user&.role.present? && current_user&.role.is_active?)
        sign_out current_user if user_signed_in?
        redirect_to new_user_session_path, alert: '您没有访问权限，请使用管理员账号登录'
      end
    end

    def log_operation(action, resource_type = nil, resource_id = nil, details = nil)
      OperationLog.create(
        user: current_user,
        action: action,
        resource_type: resource_type,
        resource_id: resource_id,
        details: details,
        ip_address: request.remote_ip,
        user_agent: request.user_agent
      )
    end
  end
end
