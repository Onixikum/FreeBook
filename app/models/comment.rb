class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  default_scope -> { order('updated_at DESC') }
  validates :book_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 3, maximum: 250 }
end
