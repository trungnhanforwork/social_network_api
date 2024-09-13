class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_image

  has_many :posts
  has_many :comments
  has_many :likes

  has_many :following_relationships, foreign_key: :follower_id, class_name: "Follow", dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed

  has_many :follower_relationships, foreign_key: :followed_id, class_name: "Follow", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  def generate_password_reset_token!
    self.reset_password_token = SecureRandom.urlsafe_base64
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid
    reset_password_sent_at < 1.hours.ago
  end

  def reset_password!(new_password)
    # update reset_password_token field to be null after reset password handle
    self.reset_password_token = nil
    self.password = new_password
    save!
  end

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
