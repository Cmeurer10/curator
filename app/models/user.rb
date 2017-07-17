class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]


  has_many :courses_curated, through: :curatorships, source: :course
  has_many :courses_taken, through: :enrollments, source: :course
  has_many :posts, dependent: :nullify
  has_many :curatorships, dependent: :nullify
  has_many :enrollments, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_format_of :username, with: /[A-z\d]*/
  validates_format_of :first_name, with: /[A-z\s]*/
  validates_format_of :last_name, with: /[A-z\s]*/

  def full_name
    first_name + ' ' + last_name
  end
end
