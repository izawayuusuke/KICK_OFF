class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :content, presence: true
end
