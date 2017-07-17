class Conversation < ApplicationRecord
  belongs_to :book
  has_many :posts, dependent: :destroy

  validates :topic, presence: true
  validates :start_index, presence: true, numericality: true
  validates :end_index, presence: true, numericality: true
end
