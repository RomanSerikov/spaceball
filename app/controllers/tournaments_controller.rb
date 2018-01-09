class TournamentsController < ApplicationController
  authorize_resource

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params[:id])
  end
end
