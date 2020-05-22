class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :active_relationships,  class_name: "Relationship", foreign_key: "follower_id",dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :rooms, through: :entries

  validates :name, presence: true

  mount_uploader :profile_image, ImageUploader

  def following?(other_user)
    following.include?(other_user)
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
