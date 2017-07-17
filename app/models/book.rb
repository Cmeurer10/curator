class Book < ApplicationRecord
  belongs_to :course
  has_many :conversations, dependent: :destroy
end
