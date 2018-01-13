class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'

  validates :start_date, :start_time, presence: true
  validates :team_a_goals, inclusion: { in: (0..50).to_a << nil }
  validates :team_b_goals, inclusion: { in: (0..50).to_a << nil }
  validate :check_teams_are_different

  private

    def check_teams_are_different
      errors.add(:team_a, "teams can't be the same") if team_a == team_b
    end
end
