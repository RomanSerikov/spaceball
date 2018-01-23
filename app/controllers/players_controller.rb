class PlayersController < ApplicationController
  authorize_resource

  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      flash[:success] = 'Player was successfully created.'
      redirect_to current_user&.team
    else
      render :new
    end
  end

  private

  def player_params
    params.require(:player).permit(:first_name, :last_name, :team_id)
  end
end
