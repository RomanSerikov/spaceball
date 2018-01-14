class Admin::MatchesController < Admin::BaseController
  before_action :set_tournament, only: %i[index new create]

  def index
    @matches = @tournament.matches
  end

  def new
    @tournament = Tournament.find(params[:tournament_id])
    @match = Match.new
  end

  def create
    @tournament = Tournament.find(params[:tournament_id])
    @match = @tournament.matches.new(match_params)

    if @match.save
      redirect_to [:admin, @match], notice: 'Match was successfully created.'
    else
      render :new
    end
  end

  def show
    @match = Match.find(params[:id])    
  end

  private

  def match_params
    params.require(:match).permit(:start_date, :start_time, :team_a_id, :team_b_id, :tournament_id)      
  end

  def set_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end
end
