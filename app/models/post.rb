class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user

  validates :content, presence: true,
                      length: { maximum: 150 }

  mount_uploader :image, ImageUploader

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
