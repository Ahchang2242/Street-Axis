class Users::SessionsController < Devise::SessionsController
  def create
    super do |user|
      if user.persisted?
        user.update(online_status: 'online')
        OperationLog.create(
          user: user,
          action: 'login_success',
          ip_address: request.remote_ip,
          user_agent: request.user_agent,
          details: '用户登录成功'
        )
      end
    end
  rescue => e
    OperationLog.create(
      user: nil,
      action: 'login_failure',
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      details: "登录失败: #{params[:user][:email]}"
    )
    raise
  end

  def destroy
    if current_user
      current_user.update(online_status: 'offline')
      OperationLog.create(
        user: current_user,
        action: 'logout',
        ip_address: request.remote_ip,
        user_agent: request.user_agent,
        details: '用户登出'
      )
    end
    super
  end
end
