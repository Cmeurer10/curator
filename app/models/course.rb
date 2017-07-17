class Course < ApplicationRecord
  has_many :curators, through: :curatorships, source: :user
  has_many :students, through: :enrollments, source: :user
  has_many :books, dependent: :destroy
  has_many :curatorships, dependent: :destroy
  has_many :enrollments, dependent: :destroy

  validates :name, presence: true
end
