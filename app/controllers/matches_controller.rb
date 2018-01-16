class MatchesController < ApplicationController
  authorize_resource

  def index
    @tournament = Tournament.find(params[:tournament_id])
    @matches = @tournament.matches
  end

  def show
    @match = Match.find(params[:id])
  end
end
