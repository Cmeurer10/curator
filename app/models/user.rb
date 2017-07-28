class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :invitable, :omniauthable, omniauth_providers: [:facebook]

  after_invitation_accepted :send_welcome_email

  mount_uploader :avatar, AvatarUploader

  has_many :courses_curated, through: :curatorships, source: :course
  has_many :courses_taken, through: :enrollments, source: :course
  has_many :books_as_curator, through: :courses_curated, source: :books
  has_many :books_as_student, through: :courses_taken, source: :books
  has_many :posts, dependent: :nullify
  has_many :curatorships, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :conversations, dependent: :nullify

  enum role: { student: 0, curator: 1, admin: 2 }

  # validates :username, presence: true, uniqueness: true
  # validates_format_of :username, with: /[A-z\d]*/
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: Devise::email_regexp
  validates :first_name, presence: true
  validates_format_of :first_name, with: /[A-z\s]*/
  validates :last_name, presence: true
  validates_format_of :last_name, with: /[A-z\s]*/

  def full_name
    first_name + ' ' + last_name
  end

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  def invite_not_accepted?
    created_by_invite? && !invitation_accepted?
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now unless self.enrollments.count > 1
  end
end
