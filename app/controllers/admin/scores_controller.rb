class Admin::ScoresController < Admin::AdminController
  before_action :set_score, only: [:show, :edit, :update, :destroy]

  def new
    @score = Score.new
    @score.match_id = params[:match_id]
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
            #players.delete(s.player_out)
            players << s.player_in
        end
    end

    @players = players
    render :layout => false
  end

  def create
    @score = Score.new(score_params)
    @match = Match.find(@score.match_id)
    respond_to do |format|
      if @score.save
        @match.update_scores
        format.html { redirect_to admin_match_path(@match) + '/scores' }
        format.json { render action: 'show', status: :created, location: @score }
      else
        format.html { render action: 'new' }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end  

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @match = Match.find(@score.match_id)
    @score.destroy
    @match.update_scores
    respond_to do |format|
      format.html { redirect_to admin_match_path(@match) + '/scores' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:player_id, :match_id, :team_id, :minute, :plus_extra_time, :is_penalty, :is_own_goal)
    end
end
