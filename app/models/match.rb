class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'
  belongs_to :winner, class_name: 'Team', optional: true
  belongs_to :loser, class_name: 'Team', optional: true

  validates :start_date, :start_time, presence: true
  validates :team_a_goals, inclusion: { in: (0..50), allow_blank: true }
  validates :team_b_goals, inclusion: { in: (0..50), allow_blank: true }
  validate :check_teams_are_different

  def self.played(tournament, team)
    tournament.matches.where(finished: true).where("team_a_id = ? or team_b_id = ?", team, team).count
  end

  def title
    "#{team_a.title} - #{team_b.title}"
  end

  def results(params)
    results = {}
    results[:draw] = true if params[:team_a_goals] == params[:team_b_goals]

    if params[:team_a_goals] > params[:team_b_goals]
      results[:winner_id] = team_a.id
      results[:loser_id] = team_b.id
    elsif params[:team_a_goals] < params[:team_b_goals]
      results[:winner_id] = team_b.id
      results[:loser_id] = team_a.id
    end

    results[:finished] = true

    update(params.merge(results))
  end

  private

    def check_teams_are_different
      errors.add(:base, "Teams can't be the same") if team_a == team_b
    end
end
