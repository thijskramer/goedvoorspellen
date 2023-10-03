class Admin::MatchTypesController < Admin::AdminController
  before_action :set_match_type, only: [:show, :edit, :update, :destroy]

  # GET /match_types
  # GET /match_types.json
  def index
    @match_types = MatchType.all
  end

  # GET /match_types/1
  # GET /match_types/1.json
  def show
  end

  # GET /match_types/new
  def new
    @match_type = MatchType.new
  end

  # GET /match_types/1/edit
  def edit
  end

  # POST /match_types
  # POST /match_types.json
  def create
    @match_type = MatchType.new(match_type_params)

    respond_to do |format|
      if @match_type.save
        format.html { redirect_to admin_match_type_path(@match_type), notice: 'Match type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @match_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @match_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /match_types/1
  # PATCH/PUT /match_types/1.json
  def update
    respond_to do |format|
      if @match_type.update(match_type_params)
        format.html { redirect_to admin_match_type_path(@match_type), notice: 'Match type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @match_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /match_types/1
  # DELETE /match_types/1.json
  def destroy
    @match_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_match_types_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match_type
      @match_type = MatchType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_type_params
      params.require(:match_type).permit(:name)
    end
end
