class Entry < ApplicationRecord
  belongs_to :blog
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  delegate :full_messages, :any?, :count, to: :errors, prefix: true
  delegate :find, :new, :where_persisted, to: :comments, prefix: true
  delegate :present?, to: :comments_where_persisted, prefix: true
end
