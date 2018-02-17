module Admin
  class TournamentsController < BaseController
    before_action :set_tournament, only: %i[show add_team remove_team]

    def index
      @tournaments = Tournament.all
    end

    def new
      @tournament = Tournament.new  
    end

    def create
      @tournament = Tournament.new(tournament_params)

      if @tournament.save
        redirect_to [:admin, @tournament], notice: 'Tournament was successfully created.'
      else
        render :new
      end
    end

    def show; end

    def add_team
      @tournament.add_team(params[:team])
      flash.now[:notice] = 'Team was successfully added.'
    end

    def remove_team
      @tournament.remove_team(params[:team])
      flash.now[:notice] = 'Team was successfully removed.'
    end

    private

    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    def tournament_params
      params.require(:tournament).permit(:title, :start_date, :end_date, :team)
    end
  end
end
