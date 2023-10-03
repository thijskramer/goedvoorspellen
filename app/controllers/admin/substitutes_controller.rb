class Admin::SubstitutesController < Admin::AdminController
  before_action :set_substitute, only: [:destroy]

  # GET /substitutes/new
  def new
    @substitute = Substitute.new
    @substitute.match_id = params[:match_id]
    @substitute.player_out_id = params[:player_out_id]
    team = Team.find(params[:team_id])
    teamplayers = team.players
    players = Array.new
    substitutions = Substitute.where(:match_id => params[:match_id])
    lineups = Lineup.where(:team_id => params[:team_id], :match_id => params[:match_id]).pluck('player_id')
    teamplayers.each do |p|
      # toon alleen players die niet opgesteld zijn en nog niet voorkomen in de wissel-lijst
      unless lineups.include?(p.id)
        if substitutions.where(:player_out_id => p.id).length == 0 && substitutions.where(:player_in_id => p.id).length == 0
          players << p
        end
      end
    end
    @players = players
    render :layout => false
  end

  def create
    @substitute = Substitute.new(substitute_params)
    @match = Match.find(@substitute.match_id)
    respond_to do |format|
      if @substitute.save
        format.html { redirect_to admin_match_path(@match) + '/substitutes', notice: 'Substitute was successfully created.' }
        format.json { render action: 'show', status: :created, location: @substitute }
      else
        format.html { render action: 'new' }
        format.json { render json: @substitute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /substitutes/1
  # DELETE /substitutes/1.json
  def destroy
    @match = Match.find(@substitute.match_id)
    @substitute.destroy
    respond_to do |format|
      format.html { redirect_to admin_match_path(@match) + '/substitutes' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_substitute
      @substitute = Substitute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def substitute_params
      params.require(:substitute).permit(:match_id, :team_id, :player_out_id, :player_in_id, :minute, :plus_extra_time)
    end
end
