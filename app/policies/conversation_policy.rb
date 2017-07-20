class ConversationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if admin?
        scope.all
      elsif curator?
        scope.where(book: user.books_as_curator)
      else
        scope.where(book: user.books_as_student)
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
    curator_or_admin? || scope.where(user: user).exists?
  end

  def edit?
    update?
  end

  def destroy?
    curator_or_admin?
  end
end
