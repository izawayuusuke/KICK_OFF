class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :update]

  def show
    @player = Player.new
    @player.belongs.new
    @players = @team.players
    @GK = @players.where(position: "GK")
    @DF = @players.where(position: "DF")
    @MF = @players.where(position: "MF")
    @FW = @players.where(position: "FW")

  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:primary] = "チームを作成しました"
      redirect_to @team
    else
      all_leagues
      @league = League.new
      render "leagues/index"
    end
  end

  def update
    if @team.update(team_params)
      flash[:primary] = "チームを更新しました"
      redirect_to @team
    else
      render :show
    end
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end
    def team_params
      params.require(:team).permit(:name, :emblem, :league_id)
    end
end
