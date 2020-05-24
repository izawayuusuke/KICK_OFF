class TeamsController < ApplicationController
  before_action :set_team, except: [:create]
  before_action :set_position, only: [:show]
  before_action :admin_user?, only: [:edit, :update]


  def show
    @player = Player.new
    @player.belongs.new
    @discussion = Discussion.new
    @discussions = @team.discussions.paginate(params, 10)
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "チームを作成しました"
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
      flash[:success] = "チームを更新しました"
      redirect_to @team
    else
      render :show
    end
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def admin_user?
      redirect_to @team unless current_user.admin == true
    end

    def team_params
      params.require(:team).permit(:name, :emblem, :league_id)
    end
end
