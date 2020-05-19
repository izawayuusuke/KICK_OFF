class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @players = @team.players
    @GK = @players.where(position: "GK")
    @DF = @players.where(position: "DF")
    @MF = @players.where(position: "MF")
    @FW = @players.where(position: "FW")

  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to teams_path
    end
  end

  def edit
  end

  private
    def team_params
      params.require(:team).permit(:name, :emblem, :league_id)
    end
end
