class User < ApplicationRecord
  has_secure_password

  has_many :posts
  has_many :comments
  has_many :likes

  has_many :following_relationships, foreign_key: :follower_id, class_name: "Follow", dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed

  has_many :follower_relationships, foreign_key: :followed_id, class_name: "Follow", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
