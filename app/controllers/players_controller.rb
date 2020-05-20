class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit]

  def show
  end

  def edit
    @teams = @player.teams
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      flash[:primary] = "選手を作成しました"
      redirect_to teams_path
    end
  end

  def update
    if @player.update
      flash[:primary] = "選手を更新しました"
    end
  end

  private
    def set_player
      @player = Player.find(params[:id])
      @belong = Belong.new
    end

    def player_params
      params.require(:player).permit(:name, :birthday, :age,
                  :height, :weight, :dominant_foot, :position, :uniform_number,
                  belongs_attributes: [:team_id, :player_id])
    end
end
