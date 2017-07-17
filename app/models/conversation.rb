class Conversation < ApplicationRecord
  belongs_to :book
  has_many :posts, dependent: :destroy
end
