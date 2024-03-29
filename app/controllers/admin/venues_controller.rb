class Admin::VenuesController < Admin::AdminController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]
  require 'csv'
  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all
    respond_to do |format|
      format.html
      format.csv {
        render text: @venues.to_csv
      }
    end
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
  end


  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to admin_venue_path(@venue), notice: 'Venue was successfully created.' }
        format.json { render action: 'show', status: :created, location: @venue }
      else
        format.html { render action: 'new' }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to admin_venue_path(@venue), notice: 'Venue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:name, :city, :latitude, :longitude, :capacity, :wikipediaUrl, :timezone, :description, :picture)
    end
end
