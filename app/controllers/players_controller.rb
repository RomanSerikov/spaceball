class PlayersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  authorize_resource

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to @player, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  def show
    @player = Player.find(params[:id])
  end

  private

  def player_params
    params.require(:player).permit(:first_name, :last_name, :team_id)
  end
end
