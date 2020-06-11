class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update]
  before_action :admin_user?, only: [:edit, :update]

  def index
    @players = Player.search(params[:search]).order(:name).paginate(params)
  end

  def show
  end

  def edit
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      flash[:success] = "選手を作成しました"
      redirect_to team_path(@player.teams.first)
    else
      @team = Team.find(params[:team_id])
      set_position
      @discussion = Discussion.new
      @discussions = @team.discussions.paginate(params)
      render "teams/show"
    end
  end

  def update
    if @player.update(player_params)
      flash[:success] = "選手を更新しました"
      redirect_to @player
    else
      render :edit
    end
  end

  private
    def set_player
      @player = Player.find(params[:id])
      @belong = Belong.new
      @teams = @player.teams
    end

    def player_params
      params.require(:player).permit(:name, :birthday, :age,
                  :height, :weight, :dominant_foot, :position, :uniform_number,
                  belongs_attributes: [:team_id, :player_id])
    end
end
