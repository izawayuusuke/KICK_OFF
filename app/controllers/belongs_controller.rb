class BelongsController < ApplicationController
  def create
    @player = Player.find(params[:player_id])
    @belong = Belong.new(belong_params)
    @belong.player_id = @player.id
    if @belong.save
      flash[:success] = "所属チームを追加しました"
      redirect_to edit_player_path(@player)
    else
      @teams = @player.teams
      render "players/edit"
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @player = Player.find(params[:id])
    Belong.find_by(player_id: @player.id, team_id: @team.id).destroy
    flash[:danger] = "所属チームを削除しました"
    redirect_to edit_player_path(@player)
  end

  private
    def belong_params
      params.require(:belong).permit(:team_id, :player_id)
    end
end
