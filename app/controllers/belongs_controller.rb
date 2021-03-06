class BelongsController < ApplicationController
  def create
    @player = Player.find(params[:player_id])
    if current_user.admin == true
      @belong = Belong.new(belong_params)
      temp = Belong.where(player_id: @player.id, team_id: @belong.team_id)
      @belong.player_id = @player.id

      if temp.present?
        flash[:info] = "既にチームに所属しています"
        redirect_to edit_player_path(@player)
      elsif @belong.save
        flash[:success] = "所属チームを追加しました"
        redirect_to edit_player_path(@player)
      else
        @teams = @player.teams
        render "players/edit"
      end
    else
      flash[:warning] = "管理者権限がありません"
      redirect_to @player
    end
  end

  def destroy
    team = Team.find(params[:team_id])
    player = Player.find(params[:id])
    if current_user.admin == true
      Belong.find_by(player_id: player.id, team_id: team.id).destroy
      flash[:danger] = "所属チームを削除しました"
      redirect_to edit_player_path(player)
    else
      flash[:warning] = "管理者権限がありません"
      redirect_to player
    end
  end

  private
    def belong_params
      params.require(:belong).permit(:team_id, :player_id)
    end
end
