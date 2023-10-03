class ClubsController < ApplicationController 
  before_action :set_club, only: [:show]

  def show
    @players = @club.wkplayers
    render :layout => false
  end

  private
  def set_club
    @club = Club.find(params[:id])
  end
end