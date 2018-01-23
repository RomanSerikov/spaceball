class MatchesController < ApplicationController
  authorize_resource

  def index
    @tournament = Tournament.find(params[:tournament_id])
    @matches = @tournament.matches
  end

  def show
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])

    if @match.update(match_params)
      flash[:success] = 'Thank you. Score will be updated after administartor verify it.'
      redirect_to @match
    else
      redirect_to @match, alert: 'Score must be in range 0..50.'
    end
  end

  private

  def match_params
    params.require(:match).permit(:team_a_goals, :team_b_goals)      
  end
end
