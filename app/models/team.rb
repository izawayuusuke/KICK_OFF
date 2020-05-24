class Team < ApplicationRecord
  has_many :belongs, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :players, through: :belongs

  belongs_to :league

  validates :name, presence: true

  mount_uploader :emblem, ImageUploader
end
