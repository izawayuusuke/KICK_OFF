class DiscussionsController < ApplicationController
  before_action :set_team

  def create
    @discussion = @team.discussions.new(discussion_params)
    @discussion.user_id = current_user.id
    if @discussion.save
      flash[:success] = "コメントを投稿しました"
      redirect_to @team
    else
      @player = Player.new
      set_position
      @discussions = @team.discussions.recent.paginate(params, 10)
      render 'teams/show'
    end
  end

  def destroy
    Discussion.find(params[:id]).destroy
    flash[:danger] = "コメントを削除しました"
    redirect_to @team
  end

  private
    def set_team
      @team = Team.find(params[:team_id])
    end

    def discussion_params
      params.require(:discussion).permit(:content)
    end

end
