class League < ApplicationRecord
  has_many :teams, dependent: :destroy

  validates :name, :classification, presence: true

  enum classification: { domestic: 1, abroad: 2, representative: 3 }
end
