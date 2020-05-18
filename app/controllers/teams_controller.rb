class TeamsController < ApplicationController
  def index
    @new_league = League.new
    @team = Team.new
    @teams = Team.all
    @new_player = Player.new
    @players = Player.all
  end

  def show
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
