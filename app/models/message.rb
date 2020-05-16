class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # create後にコミットする
  after_create_commit { MessageBroadcastJob.perform_later self }
  validates :content, presence: true
end
