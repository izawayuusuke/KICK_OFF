class Belong < ApplicationRecord
  belongs_to :player
  belongs_to :team

  validates :player_id, :team_id, uniqueness: true
end
