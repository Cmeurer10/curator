class Conversation < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :topic, presence: true
  # validates :start_index, presence: true, numericality: true
  # validates :end_index, presence: true, numericality: true

  validate :parent_or_child?, on: :create

  def parent_or_child?
    # byebug
    errors.add(:parent_or_child, "Cannot be an orphan") unless parent? ^ child?
  end

  def parent?
    end_index.present? && start_index.present?
  end

  def child?
    parent_id.present?
  end
end
