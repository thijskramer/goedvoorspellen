class Admin::TeamsController < Admin::AdminController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = FootballTeam.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    players = Player.where(country_id: @team.country_id, inSquad: true).sort_by { |x| [x.positionId, x.inSquad ? 0 : 1, x.lastName, x.firstName]}
    if @team.selection_type == nil || @team.selection_type == ''
        players = Player.where(country_id: @team.country_id).sort_by { |x| [x.positionId, x.inSquad ? 0 : 1, x.lastName, x.firstName]}
    end
    if params[:sort] == 'number'
        @players = players.sort_by {|x| (x.number.nil? ? 99 : x.number)}
        @sort = 'number'
    else
        @players = players
    end
    # .sort { |a, b| [a['positionId'], a['inSelection']] <=> [b['positionId'], b['inSelection']] }
  end

  # GET /teams/new
  def new
    @team = FootballTeam.new
    @coach = Coach.new
  end

  # GET /teams/1/edit
  def edit
    @coach = Coach.new
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = FootballTeam.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to admin_team_path(@team), notice: 'Team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team }
      else
        format.html { render action: 'new' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to admin_team_path(@team), notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:country_id, :FIFAranking, :associationFull, :associationAbbreviation, :coach_id, :group_id, :logo, :best_result, :appearances, :selection_type)
    end
end
