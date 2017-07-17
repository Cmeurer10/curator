class Course < ApplicationRecord
  has_many :curators, through: :curatorship, source: :user
  has_many :students, through: :enrollment, source: :user
  has_many :books, dependent: :destroy
  has_many :curatorships, dependent: :destroy
  has_many :enrollments, dependent: :destroy
end
