class Admin::MatchesController < Admin::BaseController
  before_action :set_tournament, only: %i[index new create]
  before_action :set_match, only: %i[show update]

  def index
    @matches = @tournament.matches
  end

  def new
    @match = Match.new(start_date: @tournament.start_date)
  end

  def create
    @match = @tournament.matches.new(match_params)

    if @match.save
      redirect_to [:admin, @match], notice: 'Match was successfully created.'
    else
      render :new
    end
  end

  def show; end

  def update
    if @match.results(match_params)
      redirect_to [:admin, @match], notice: 'Match was successfully updated.'
    else
      redirect_to [:admin, @match], alert: 'Score must be in range 0..50.'
    end
  end

  private

  def match_params
    params.require(:match).permit(
      :start_date,
      :start_time,
      :team_a_id,
      :team_b_id,
      :tournament_id,
      :team_a_goals,
      :team_b_goals,
      :finished,
      :winner_id,
      :loser_id,
      :draw
    )      
  end

  def set_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end

  def set_match
    @match = Match.find(params[:id])
  end
end
