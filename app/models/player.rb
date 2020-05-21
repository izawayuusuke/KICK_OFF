class Player < ApplicationRecord
  has_many :belongs, dependent: :destroy
  accepts_nested_attributes_for :belongs
  has_many :teams, through: :belongs
  validates :name, :height, :weight, :age, :uniform_number, presence: true

  enum dominant_foot: { right_foot: 1, left_foot: 2, both_foot: 3 }
  enum position: { GK: 1, DF: 2, MF: 3, FW: 4 }
end
