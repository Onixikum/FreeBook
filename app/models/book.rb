class Book < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments

  default_scope -> { order('updated_at DESC') }
  validates :name,        presence: true, length: { minimum: 3, maximum: 50 }
  validates :author,      presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
end
