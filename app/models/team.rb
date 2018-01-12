class Team < ApplicationRecord
  has_many :tournaments_teams
  has_many :tournaments, through: :tournaments_teams

  has_many :players
  
  validates :title, presence: true

  def self.not_participating(tournament)
    where.not(id: tournament.teams)
  end
end
