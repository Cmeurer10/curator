class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :courses_curated, through: :curatorship, source: :course
  has_many :courses_taken, through: :enrollment, source: :course
  has_many :posts, dependent: :nullify
  has_many :curatorships, dependent: :nullify
  has_many :enrollments:, dependent: :destroy
end
