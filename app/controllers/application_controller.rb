class ApplicationController < ActionController::Base
  # 退出登录后重定向到登录页面
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  # 登录后重定向到相应页面
  def after_sign_in_path_for(resource)
    if resource.is_admin? || resource.role.present?
      admin_root_path
    else
      root_path
    end
  end
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
