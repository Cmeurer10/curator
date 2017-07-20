class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if admin?
        scope.all
      elsif curator?
        user_acessible_posts = []
        user.books_as_curator.each{ |book| user_acessible_posts.push(*book.posts) }
        scope.where(conversation: user_acessible_posts)
      else
        user_acessible_posts = []
        user.books_as_student.each{ |book| user_acessible_posts.push(*book.posts) }
        scope.where(conversation: user_acessible_posts)
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

  def edit?
    update?
  end

  def destroy?
    curator_or_admin?
  end
end
