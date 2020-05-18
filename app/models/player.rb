class Player < ApplicationRecord
  has_many :belongs, dependent: :destroy
  has_many :teams, through: :belongs

  validates :name, :height, :weight, :age, presence: true

  enum dominant_foot: { 右足: 1, 左足: 2, 両足: 3 }
  enum position: { GK: 1, DF: 2, MF: 3, FW: 4 }
end
