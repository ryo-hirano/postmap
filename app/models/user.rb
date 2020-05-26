class User < ApplicationRecord
  has_many :posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  mount_uploader :image, ImageUploader

  validates :nickname, length: { maximum: 20 }, presence: true
  validates :introduction, length: { maximum: 200 }
end
