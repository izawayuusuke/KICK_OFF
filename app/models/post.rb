class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user

  validates :content, presence: true,
                      length: { maximum: 150 }

  mount_uploader :image, ImageUploader

  def liked_by?(user)
    likes.where(user_id: user_id).exists?
  end
end
