class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :edit, :update, :security, :courses, :new_course, :create_course, :edit_course, :update_course, :destroy_course]
  
  def profile
    @user = current_user
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_profile_path, notice: '个人资料更新成功'
    else
      render :edit
    end
  end
  
  def security
    @user = current_user
  end
  
  def update_password
    @user = current_user
    if @user.update_with_password(password_params)
      # 清除所有会话，只保留当前会话
      bypass_sign_in(@user)
      redirect_to user_profile_path, notice: '密码更新成功'
    else
      render :security
    end
  end
  
  def courses
    @user = current_user
    @courses = @user.courses
  end
  
  def new_course
    @user = current_user
    @course = @user.courses.build
  end
  
  def create_course
    @user = current_user
    @course = @user.courses.build(course_params)
    if @course.save
      redirect_to user_courses_path, notice: '课程创建成功'
    else
      render :new_course
    end
  end
  
  def edit_course
    @user = current_user
    @course = @user.courses.find(params[:id])
  end
  
  def update_course
    @user = current_user
    @course = @user.courses.find(params[:id])
    if @course.update(course_params)
      redirect_to user_courses_path, notice: '课程更新成功'
    else
      render :edit_course
    end
  end
  
  def destroy_course
    @user = current_user
    @course = @user.courses.find(params[:id])
    @course.destroy
    redirect_to user_courses_path, notice: '课程删除成功'
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email)
  end
  
  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
  
  def course_params
    params.require(:course).permit(:title, :description)
  end
end
