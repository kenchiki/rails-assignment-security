class Blog < ApplicationRecord
  has_many :entries, dependent: :destroy
  validates :title, presence: true
  delegate :new, :present?,:find, to: :entries, prefix: true
  delegate :any?, :count, :full_messages, to: :errors, prefix: true

  def index
    Blog.all
  end
end
