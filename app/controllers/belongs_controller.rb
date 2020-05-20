class BelongsController < ApplicationController
  def create
    @player = Player.find(params[:player_id])
    @belong = Belong.new(belong_params)
    @belong.player_id = @player.id
    if @belong.save
      redirect_to @player
    else
      @teams = @player.teams
      render "players/edit"
    end
  end

  private
    def belong_params
      params.require(:belong).permit(:team_id, :player_id)
    end
end
