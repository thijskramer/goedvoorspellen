class Admin::PenaltiesController < Admin::AdminController
  before_action :set_penalty, only: [:show, :edit, :update, :destroy]

  def new
    @penalty = Penalty.new
    @penalty.match_id = params[:match_id]
    match = Match.find(params[:match_id])
    players = Array.new
    if(params[:team_id] == match.awayteam_id.to_s)
        match.awaylineups.each do |l|
            players << l.player
        end
    end
    if(params[:team_id] == match.hometeam_id.to_s)
        match.homelineups.each do |l|
            players << l.player
        end
    end
    match.substitutes.each do |s|
        if players.include?(s.player_out)
            players << s.player_in
        end
    end

    @players = players
    render :layout => false
  end

  # GET /penalties/1/edit
  def edit
  end

  # POST /penalties
  # POST /penalties.json
  def create
    @penalty = Penalty.new(penalty_params)
    @match = Match.find(@penalty.match_id)
    respond_to do |format|
      if @penalty.save
        #@match.update_scores
        format.html { redirect_to admin_match_path(@match) + '/penalties' }
        format.json { render action: 'show', status: :created, location: @penalty }
      else
        format.html { render action: 'new' }
        format.json { render json: @penalty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /penalties/1
  # DELETE /penalties/1.json
  def destroy
    @match = Match.find(@penalty.match_id)
    @penalty.destroy

    respond_to do |format|
      format.html { redirect_to admin_match_path(@match) + '/penalties' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_penalty
      @penalty = Penalty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def penalty_params
      params.require(:penalty).permit(:match_id, :team_id, :player_id, :misses)
    end
end
