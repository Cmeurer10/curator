class CuratorshipsController < ApplicationController
  # TODO: add authorization
  before_action :set_course, except: [:index]
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @curatorships = Curatorship.all
  end

  def new
    @curatorship = Curatorship.new
    @users = User.all.reject { |u| u.courses_curated.include?(@course) }
  end

  def create
    @curatorship = Curatorship.new(curatorship_params)
    @curatorship.course = @course
    @curatorship.user.role = 'curator'

    if @curatorship.save
      same_course_enrollment = Enrollment.where(user: @curatorship.user, course: @course).first
      same_course_enrollment.destroy if same_course_enrollment
      redirect_to edit_course_path(@course)
    end
  end

  def destroy
    @curatorship = Curatorship.find(params[:id])
    @curatorship.user.role = 'student' if @curatorship.user.curatorships.first.nil?
    @curatorship.destroy
    redirect_to edit_course_path(@course)
  end

  private

  def set_course
    @course = Course.find(params[:course_id]) unless params[:course_id].nil?
  end

  def curatorship_params
    params.require(:curatorship).permit(:user_id)
  end
end
