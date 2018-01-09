class TeamsController < ApplicationController
  authorize_resource

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end
end
