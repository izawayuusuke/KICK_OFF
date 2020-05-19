class LeaguesController < ApplicationController
  def index
    @league = League.new
    @leagues = League.all
    @team = Team.new
    @teams = Team.all
    @player = Player.new
    @players = Player.all
    @belong = Belong.new
  end

  def show
    @league = League.find(params[:id])
  end

  def create
    @new_league = League.new(league_params)
    if @new_league.save
      redirect_to leagues_path
    end
  end

  private
    def league_params
      params.require(:league).permit(:name, :home_abroad_representative)
    end
end
