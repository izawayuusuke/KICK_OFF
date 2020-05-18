class League < ApplicationRecord
  validates :name, presence: true

  enum home_abroad_representative: { 国内: 1, 海外: 2, 代表: 3 }
end
