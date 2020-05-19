class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @players = Player.all
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
