class Admin::BookingsController < Admin::AdminController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings/new
  def new
    @booking = Booking.new
    @booking.match_id = params[:match_id]
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

  # POST /bookings
  def create
    @booking = Booking.new(booking_params)
    @match = Match.find(@booking.match_id)
    respond_to do |format|
      if @booking.save
        format.html { redirect_to admin_match_path(@match) + '/bookings' }
        format.json { render action: 'show', status: :created, location: @booking }
      else
        format.html { render action: 'new' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end  

  def destroy
    @match = Match.find(@booking.match_id)
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to admin_match_path(@match) + '/bookings' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:match_id, :team_id, :player_id, :minute, :plus_extra_time, :is_yellow_card, :is_red_card)
    end
end
