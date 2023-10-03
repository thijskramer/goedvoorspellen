class PredictionsController < ApplicationController
    before_action :require_login
    before_action :set_prediction, only: [:update]

  def index
    @predictions = Prediction.where(user_id: current_user.id).joins(:match).order('matches.startDate')
    current_user.last_visited = DateTime.now
    current_user.save
  end

  def update
    respond_to do |format|
      if @prediction.match.startDate > DateTime.now && @prediction.user_id == current_user.id
          if @prediction.update(prediction_params)
            format.html { redirect_to @prediction, notice: 'Prediction was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: 'edit' }
            format.json { render json: @prediction.errors, status: :unprocessable_entity }
          end
       else
        format.json { render nothing: :true, status: :gone }
       end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prediction
      @prediction = Prediction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prediction_params
      params.require(:prediction).permit(:match_id, :home_score, :away_score)
    end
end
