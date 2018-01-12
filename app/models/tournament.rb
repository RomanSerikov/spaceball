class Tournament < ApplicationRecord
  has_many :tournaments_teams
  has_many :teams, through: :tournaments_teams

  validates :title, :start_date, :end_date, presence: true

  def add_team(team_id)
    teams << Team.find(team_id)
  end

  def remove_team(team_id)
    teams.delete(team_id)
  end
end
