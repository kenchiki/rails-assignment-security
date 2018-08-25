class Comment < ApplicationRecord
  belongs_to :entry
  enum status: {unapproved: 1, approved: 2}
  validates :body, presence: true
  delegate :full_messages, :any?, :count, to: :errors, prefix: true

  scope :where_persisted, -> {
    where.not(id: nil)
  }
end
