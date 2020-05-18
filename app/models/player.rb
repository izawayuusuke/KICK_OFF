class Player < ApplicationRecord
  has_many :belongs, dependent: :destroy
  has_many :teams, through: :belongs
end
