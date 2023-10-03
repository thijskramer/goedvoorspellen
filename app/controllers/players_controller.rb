class PlayersController < ApplicationController
  before_action :set_player, only: [:show]
  before_action :set_team, only: [:index, :show]

  def index
    @players = Player.where(:country_id => @team.country_id)
  end

  def show

  end

  private
  def set_player
    @player = Player.friendly.find(params[:id])
  end
  def set_team
    @team = Team.friendly.find(params[:team_id])
  end  
end
