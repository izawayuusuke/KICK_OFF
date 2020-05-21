class TeamsController < ApplicationController
  before_action :set_team, exept: [:create]
  before_action :set_position, only: [:show]

  def show
    @player = Player.new
    @player.belongs.new
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

  def edit
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
