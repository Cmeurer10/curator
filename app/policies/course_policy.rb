class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if admin?
        scope.all
      elsif curator?
        scope.where(course: user.courses_curated)
      else
        scope.where(course: user.courses_taken)
      end
    end
  end


  def index?
    true
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    curator_or_admin?
  end

  def edit?
    update?
  end

  def destroy?
    curator_or_admin?
  end
end
