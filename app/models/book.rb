class Book < ApplicationRecord
  belongs_to :course
  has_many :conversations, dependent: :destroy
  has_many :posts, through: :conversations

  mount_uploader :file, BookFileUploader

  validates :title, presence: true
  validates :author, presence: true
  # validates :isbn, presence: true
  validates :publisher, presence: true
end
