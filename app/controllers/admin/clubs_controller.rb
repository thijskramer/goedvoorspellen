class Admin::ClubsController < Admin::AdminController
  before_action :set_club, only: [:show, :edit, :update, :destroy]

  # GET /clubs
  # GET /clubs.json
  def index
    @clubs = Club.all.order(:country_id, :name)
  end

  # GET /clubs/1
  # GET /clubs/1.json
  def show
    @players = @club.players
  end

  # GET /clubs/new
  def new
    @club = Club.new
  end

  # GET /clubs/1/edit
  def edit
  end

  # POST /clubs
  # POST /clubs.json
  def create
    @club = Club.new(club_params)

    respond_to do |format|
      if @club.save
        format.html { redirect_to admin_club_path(@club), notice: 'Club was successfully created.' }
        format.json { render action: 'show', status: :created, location: @club }
      else
        format.html { render action: 'new' }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clubs/1
  # PATCH/PUT /clubs/1.json
  def update
    respond_to do |format|
      if @club.update(club_params)
        format.html { redirect_to admin_club_path(@club), notice: 'Club was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1
  # DELETE /clubs/1.json
  def destroy
    @club.destroy
    respond_to do |format|
      format.html { redirect_to admin_clubs_url }
      format.json { head :no_content }
    end
  end

  # def import
  #   File.open('json/clubs.json', 'r') do |file|
  #     file.each do |line|
  #       # user_attrs = JSON.parse line
  #       clubs = JSON.parse line
  #       clubs.each do |c|

  #         country = Country.find_by name: c['country'];

  #         club = Club.new
  #         club.name = c['name']
  #         club.country_id = country.id
  #         club.save
  #       end

  #     end
  #   end
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = Club.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def club_params
      params.require(:club).permit(:name, :country_id)
    end
end
