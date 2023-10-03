class VenuesController < ApplicationController
  before_action :set_venue, only: [:show]

  def index
    @venues = Venue.all
  end

  def show
    
  end

  private
    def set_venue
      @venue = Venue.friendly.find(params[:id])
    end
end
