class Admin::PlayersController < Admin::AdminController
  before_action :set_player, only: [:show, :edit, :update, :destroy, :select]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show

  end

  # GET /players/new
  def new 
    @player = Player.new
    team = Team.find(params[:team_id])
    @player.country_id = team.country_id
    @player.inSquad = true
    @clubs = Club.all
    countries = []
    @clubs.each do |c| 
      countries << c.country
    end
    @countries = countries.uniq
    render :layout => false
    
  end 

  # GET /players/1/edit
  def edit
    @clubs = Club.all
    countries = []
    @clubs.each do |c| 
      countries << c.country
    end
    @countries = countries.uniq
    render :layout => false
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        team = Team.find_by country_id: @player.country_id
        format.html { redirect_to admin_team_path(team.id), notice: 'Player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player }
      else
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
          team = Team.friendly.find_by country_id: @player.country_id
        format.html { redirect_to admin_team_path(team.id), notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def select
    respond_to do |format|
      @player.inSquad = params[:inSquad]
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end 

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to admin_players_url }
      format.json { head :no_content }
    end
  end

  # def import
  #   File.open('json/players.json', 'r') do |file|
  #     file.each do |line|
  #       # user_attrs = JSON.parse line
  #       players = JSON.parse line
  #       players.each do |c|

  #         country = Country.find_by name: c['nationality']
  #         club = Club.find_by name: c['club']
  #         player = Player.new
  #         player.firstName = c['firstName']
  #         player.lastName = c['lastName']
  #         player.country_id = country.id
  #         player.position = c['position']
  #         player.club_id = club == nil ? nil : club.id
  #         player.number = c['number']
  #         player.isCaptain = c['isCaptain']
  #         player.isViceCaptain = c['isViceCaptain']
  #         player.caps = c['caps']
  #         player.goals = c['goals']
  #         player.dateOfBirth = Date.parse(c['dateOfBirth'])
  #         player.inSquad = c['inSelection']

  #         player.save
  #       end

  #     end
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:firstName, :lastName, :country_id, :position, :club_id, :number, :isCaptain, :isViceCaptain, :caps, :goals, :dateOfBirth, :inSquad)
    end
end
