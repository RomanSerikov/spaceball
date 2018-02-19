class Tournament < ApplicationRecord
  has_many :tournaments_teams
  has_many :teams, through: :tournaments_teams
  has_many :matches

  validates :title, :start_date, :end_date, presence: true

  def add_team(team_id)
    teams << Team.find(team_id)
  end

  def remove_team(team_id)
    teams.delete(team_id)
  end

  def table
    current_table = "Tournament table: \n"

    Team.by_points(self).each.with_index(1) do |team, i|
      current_table << "#{i}. #{team.title}. Points: #{team.points(self)} \n"
    end

    current_table
  end

  def auto_start_date
    next_day_after_last_match || start_date
  end

  private

  def next_day_after_last_match
    matches.last.start_date + 1.day if matches.present?
  end
end
