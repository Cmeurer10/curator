class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if admin?
        scope.all
      elsif curator?
        scope.joins(conversation: {book: :course}).where(books: {course_id: user.courses_curated_ids})
      else
        scope.joins(conversation: {book: :course}).where(books: {course_id: user.courses_taken_ids})
      end
    end
  end


  def index?
    scope
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    scope
  end

  def new?
    create?
  end

  def update?
    admin? || scope.where(user: user)
  end

  def upvote?
    scope
  end

  def flag?
    curator_or_admin?
  end

  def edit?
    update?
  end

  def destroy?
    curator_or_admin?
  end
end
