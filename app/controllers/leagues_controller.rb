class LeaguesController < ApplicationController
  before_action :new_league_team, except: [:create]
  before_action :set_league, only: [:show, :update]
  before_action :admin_user?, only: [:update]

  def index
    all_leagues
  end

  def show
    choose_league_class(@league.classification)
    @teams = @league.teams
  end

  def create
    @league = League.new(league_params)
    if @league.save
      flash[:success] = "リーグを作成しました"
      redirect_to @league
    else
      all_leagues
      @team = Team.new
      render :index
    end
  end

  def update
    if @league.update(league_params)
      flash[:success] = "リーグを更新しました"
      redirect_to @league
    else
      choose_league_class(@league.classification)
      @teams = @league.teams
      render :show
    end
  end

  def domestic
    choose_league_class(1)
  end

  def abroad
    choose_league_class(2)
  end

  def representative
    choose_league_class(3)
  end

  private
    def set_league
      @league = League.find(params[:id])
    end

    def new_league_team
      @league = League.new
      @team = Team.new
    end

    def choose_league_class(classification)
      @leagues = League.where(classification: classification)
      @teams = [] # リーグに紐づいたチームの受け皿
      @leagues.map { |league| @teams += league.teams }
    end

    def league_params
      params.require(:league).permit(:name, :classification)
    end
end
