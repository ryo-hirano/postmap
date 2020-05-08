class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :images
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  belongs_to :category, optional: true

  def self.search(search)
    return Post.all unless search
    Post.where('text LIKE(?)', "%#{search}%")
  end
end
