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
    results = { 
      finished: true,
      draw: check_draw(params),
      winner_id: who_win(params),
      loser_id: who_lose(params)
    }

    update(params.merge(results))
  end

  private

  def check_teams_are_different
    errors.add(:base, "Teams can't be the same") if team_a == team_b
  end

  def check_draw(params)
    params[:team_a_goals] == params[:team_b_goals]
  end

  def who_win(params)
    return nil if check_draw(params)
    params[:team_a_goals] > params[:team_b_goals] ? team_a.id : team_b.id
  end

  def who_lose(params)
    return nil if check_draw(params)
    params[:team_a_goals] < params[:team_b_goals] ? team_a.id : team_b.id
  end
end
