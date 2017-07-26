class UsersController < ApplicationController
  skip_after_action :verify_authorized
  before_action :set_course

  def new
    @user = User.new
  end

  def invite
    users = User.where(email: user_params[:email])
    user = users.empty? ? User.new : users.first
    user.email = user_params[:email]
    user.invite!
    enrollment = Enrollment.new
    enrollment.course = @course
    enrollment.user = user
    enrollment.save
    redirect_to edit_course_path
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
