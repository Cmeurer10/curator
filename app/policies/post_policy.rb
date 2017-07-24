class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if admin?
        scope.all
      elsif curator?
        # if user.courses_curated_ids.count > 1
        #   array = user.courses_curated_ids
        # else
        #   array = [user.courses_curated.first.id]
        # end
        scope.joins(conversation: {book: :course}).where(books: {course_id: user.courses_curated_ids})
        # scope.where(conversation: { book: {course_id: user.courses_curated_ids}})

        # user_acessible_posts = []
        # user.books_as_curator.each{ |book| user_acessible_posts.push(*book.posts) }
        # scope.where(conversation: user_acessible_posts)
      else
        scope.joins(conversation: {book: :course}).where(books: {course_id: user.courses_taken_ids})
        # scope.includes(conversation: {book: :course}).where(conversation: { books: {course_id: user.courses_taken_ids}})

        # user_acessible_posts = []
        # user.books_as_student.each{ |book| user_acessible_posts.push(*book.posts) }
        # scope.where(conversation: user_acessible_posts)
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
