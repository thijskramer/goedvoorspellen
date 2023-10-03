class Admin::LineupsController < Admin::AdminController
  # before_action :set_lineup, only: [:show, :edit, :update, :destroy]

  def toggle_lineup
    lineup = Lineup.find_by(match_id: params[:match_id], team_id: params[:team_id], player_id: params[:player_id])
    if lineup == nil
      lineup = Lineup.new
      lineup.match_id = params[:match_id]
      lineup.team_id = params[:team_id]
      lineup.player_id = params[:player_id]
      lineup.save
    else
      Lineup.destroy(lineup)
    end
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def players
    @match = Match.find(params[:match_id])
    @homeplayers = @match.hometeam.players
    @awayplayers = @match.awayteam.players
    lineups = Array.new
    Lineup.where(match_id: params[:match_id]).each do |l|
      lineups << l.player_id
    end
    @lineups = lineups
  end
  
  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_lineup
  #     @lineup = Lineup.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def lineup_params
  #     params.require(:lineup).permit(:match_id, :team_id, :player_id)
  #   end
end
