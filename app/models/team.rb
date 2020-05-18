class Team < ApplicationRecord
  has_many :belongs, dependent: :destroy
  has_many :players, through: :belongs

  validates :name, presence: true
end
