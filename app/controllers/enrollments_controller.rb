class EnrollmentsController < ApplicationController
  # TODO: add authorization
  before_action :set_course, except: [:index]
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @enrollments = Enrollment.all
  end

  def new
    @enrollment = Enrollment.new
    @users = User.all.reject { |u| u.courses_taken.include?(@course) }
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    @enrollment.course = @course

    if @enrollment.save
      @enrollment.user.role = 'student'
      same_course_curatorship = Curatorship.where(user: @enrollment.user, course: @course).first
      same_course_curatorship.destroy if same_course_curatorship
      redirect_to edit_course_path(@course)
    end
  end

  def destroy
    @enrollment.destroy
    redirect_to edit_course_path(@course)
  end

  private

  def set_course
    @course = Course.find(params[:course_id]) unless params[:course_id].nil?
  end

  def enrollment_params
    params.require(:enrollment).permit(:user_id)
  end
end
