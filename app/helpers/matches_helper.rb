module MatchesHelper
  def can_score?(user, game)
    return false unless user&.captain?
    return false unless game.team_a_goals.nil?
    
    user.team == game.team_a || user.team == game.team_b
  end
end
