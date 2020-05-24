class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # create後にコミットする
  after_create_commit { MessageBroadcastJob.perform_later self, user_id }

  validates :content, presence: true
end
