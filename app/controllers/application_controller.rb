class ApplicationController < ActionController::Base
  # 退出登录后重定向到登录页面
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
