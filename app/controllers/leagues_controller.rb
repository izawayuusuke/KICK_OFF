class LeaguesController < ApplicationController
  def create
    @new_league = League.new(league_params)
    if @new_league.save
      redirect_to teams_path
    end
  end

  private
    def league_params
      params.require(:league).permit(:name, :home_abroad_representative)
    end
end
