class Team < ApplicationRecord
  has_many :tournaments_teams
  has_many :tournaments, through: :tournaments_teams

  has_many :players
  has_many :matches
  
  validates :title, presence: true

  def self.not_participating(tournament)
    where.not(id: tournament.teams)
  end

  def self.by_points(tournament)
    tournament.teams.sort_by { |team| team.points(tournament) }.reverse
  end

  def played(tournament)
    tournament.matches.where(finished: true).where("team_a_id = ? or team_b_id = ?", self, self).count
  end

  def wins(tournament)
    tournament.matches.where(winner: self).count
  end

  def loss(tournament)
    tournament.matches.where(loser: self).count
  end

  def draw(tournament)
    tournament.matches.where(draw: true).where("team_a_id = ? or team_b_id = ?", self, self).count
  end

  def points(tournament)
    (wins(tournament) * 3) + draw(tournament)
  end
end
