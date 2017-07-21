class EnrollmentsController < ApplicationController
  # TODO: add authorization
  before_action :set_course_id
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @enrollments = Enrollment.all
  end

  def new
    @enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    @enrollment.course = @course

    if @enrollment.save
      redirect_to
    end
  end

  def destroy
  end

  private

  def set_course_id
    @course = Course.find(:course_id)
  end

  def enrollment_params
    params.require(:enrollment).permit(:user_id)
  end
end
