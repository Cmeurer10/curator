class CuratorshipsController < ApplicationController
  # TODO: add authorization
  before_action :set_course_id
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @curatorships = Curatorship.all
  end

  def new
    @curatorship = Curatorship.new
  end

  def create
    @curatorship = Curatorship.new(curatorship_params)
    @curatorship.course = @course

    if @curatorship.save
      redirect_to
    end
  end

  def destroy
  end

  private

  def set_course_id
    @course = Course.find(:course_id)
  end

  def curatorship_params
    params.require(:curatorship).permit(:user_id)
  end
end
