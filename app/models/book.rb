class Book < ApplicationRecord
  belongs_to :course
  has_many :conversations, dependent: :destroy

  mount_uploader :path, BookContentUploader

  validates :title, presence: true
  validates :author, presence: true
  # validates :isbn, presence: true
  validates :publisher, presence: true
end
