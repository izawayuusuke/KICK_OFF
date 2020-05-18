class PlayersController < ApplicationController
  before_action :set_player

  def show
  end

  def edit
  end

  def create

  end

  private
    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:name, :birthday, :age,
                  :height, :weight, :dominant_foot, :position)
    end
end
