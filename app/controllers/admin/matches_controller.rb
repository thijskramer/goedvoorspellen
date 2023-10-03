class Admin::MatchesController < Admin::AdminController
  before_action :set_match, only: [:show, :lineup, :scores, :edit, :update, :destroy, :players, :substitutes, :bookings, :penalties]

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all.order(:startDate)
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  def lineup
  end

  def scores
  end

  def substitutes
    @substitutions = Substitute.where(:match_id => @match.id)
  end

  def bookings
  end

  def penalties
  end
  

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to admin_matches_path, notice: 'Match was successfully created.' }
      else
        format.html { render action: 'new' }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
        @match.slug = nil
        if @match.hometeam_id_changed? || @match.awayteam_id_changed?
            @match.slug = nil
        end
      if @match.update(match_params)
        format.html { redirect_to admin_matches_path, notice: 'Match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:number, :matchtype_id, :hometeam_id, :awayteam_id, :homePlaceholder, :awayPlaceholder, :homeScore, :awayScore, :stadium_id, :referee_id, :startDate)
    end
end
