class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'

  validates :start_date, :start_time, presence: true
  validates :team_a_goals, inclusion: { in: (0..50), allow_blank: true }
  validates :team_b_goals, inclusion: { in: (0..50), allow_blank: true }
  validate :check_teams_are_different

  def title
    "#{team_a.title} - #{team_b.title}"
  end

  def self.played(tournament, team)
    where(tournament: tournament).where(team_a: team).or(Match.where(team_b: team)).count
  end

  private

    def check_teams_are_different
      errors.add(:base, "Teams can't be the same") if team_a == team_b
    end
end
