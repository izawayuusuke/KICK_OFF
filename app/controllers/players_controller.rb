class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit]

  def show
    @belong = Belong.new
  end

  def edit
  end

  def create
    @new_player = Player.new(player_params)
    if @new_player.save
      redirect_to leagues_path
    end
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:name, :birthday, :age,
                  :height, :weight, :dominant_foot, :position, :team_id)
    end
end
