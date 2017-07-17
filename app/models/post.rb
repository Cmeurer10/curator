class Post < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :votes, presence: true, numericality: true
  validates :votes, presence: true, numericality: true
end
