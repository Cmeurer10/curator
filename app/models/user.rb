class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :courses_curated, through: :curatorships, source: :course
  has_many :courses_taken, through: :enrollments, source: :course
  has_many :posts, dependent: :nullify
  has_many :curatorships, dependent: :nullify
  has_many :enrollments:, dependent: :destroy
end
