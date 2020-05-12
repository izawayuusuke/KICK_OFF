class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :shares, dependent: :destroy
  belongs_to :user

  validates :content, presence: true,
                      length: { maximum: 150 }

  mount_uploader :image, ImageUploader

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def shared_by?(user)
    shares.where(user_id: user.id).exists?
  end
end
