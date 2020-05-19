class League < ApplicationRecord
  has_many :teams, dependent: :destroy

  validates :name, presence: true

  enum classification: { 国内: 1, 海外: 2, 代表: 3 }
end
