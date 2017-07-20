class EnrollmentsController < ApplicationController
  # TODO: add authorization
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
  end

  def new
  end

  def create
  end

  def destroy
  end
end
