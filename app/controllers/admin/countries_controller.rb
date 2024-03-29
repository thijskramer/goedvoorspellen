class Admin::CountriesController < Admin::AdminController
  before_action :set_country, only: [:show, :edit, :update, :destroy]

  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.all
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
  end

  # GET /countries/new
  def new
    @country = Country.new
  end

  # GET /countries/1/edit
  def edit
  end

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.new(country_params)

    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: 'Country was successfully created.' }
        format.json { render action: 'show', status: :created, location: @country }
      else
        format.html { render action: 'new' }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /countries/1
  # PATCH/PUT /countries/1.json
  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to @country, notice: 'Country was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to countries_url }
      format.json { head :no_content }
    end
  end

  # def import
  #   File.open('json/countries.json', 'r') do |file|
  #     file.each do |line|
  #       # user_attrs = JSON.parse line
  #       countries = JSON.parse line
  #       countries.each do |c|
          
  #         country = Country.new
  #         # logger.debug c['name']
  #         country.name = c['name']
  #         country.dutchName = c['dutchName']
  #         country.isoAlpha2Code = c['isoAlpha2']
  #         country.isoAlpha3Code = c['isoAlpha3']
  #         country.isoNumericCode = c['isoNumeric']
  #         country.FIFAcode = c['FIFAcode']
  #         country.save
          
  #       end

  #     end
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def country_params
      params.require(:country).permit(:name, :dutchName, :isoAlpha2Code, :isoAlpha3Code, :isoNumericCode, :FIFAcode)
    end
end
