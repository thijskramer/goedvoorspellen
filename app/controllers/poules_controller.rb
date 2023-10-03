class PoulesController < ApplicationController
  before_action :set_poule, only: [:show, :edit, :join, :leave, :update, :destroy]
  before_action :require_login, only: [:new, :edit, :create, :join, :leave, :update, :destroy]

  def show
    
  end

  def new
    @poule = Poule.new
    @poule.publicly_visible = true
  end

  def edit
    if @poule.admin_id != current_user.id
        redirect_to rankings_path
    end
  end

  def create
    @poule = Poule.new(poule_params)
    respond_to do |format|
      if @poule.save
        Poule.add_creator_to_poule(current_user.id, @poule.id)
        format.html { redirect_to @poule, notice: 'Je poule met de naam "' + @poule.name + '" is aangemaakt.' }
        format.json { render action: 'show', status: :created, location: @poule }
      else
        format.html { render action: 'new' }
        format.json { render json: @poule.errors, status: :unprocessable_entity }
      end
    end
  end

  def join 
    unless current_user.poules.exists?(@poule.id)
        if @poule.is_protected
            if params[:password] != @poule.password
                flash[:wrongpass] = "Wachtwoord is onjuist"
                redirect_to poule_path(@poule) and return
            end
        end    
        participation = Participation.new
        participation.user_id = current_user.id
        participation.poule_id = @poule.id
        participation.is_admin = false
        participation.save!
        redirect_to @poule, notice: 'Je neemt vanaf nu deel aan deze poule!'
    end
  end

  def leave
    if @poule.admin_id == current_user.id
        redirect_to poule_path(@poule) and return
    end
    if current_user.poules.exists?(@poule.id)
        participation = Participation.where(poule_id: @poule.id, user_id: current_user.id).take
        participation.destroy
        redirect_to rankings_path
    end
  end

  def update
    if @poule.admin_id != current_user.id
        redirect_to rankings_path and return
    end
    respond_to do |format|
      if @poule.update(poule_params)
        format.html { redirect_to @poule, notice: 'De wijzigingen in "' + @poule.name + '" zijn opgeslagen.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @poule.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    if @poule.admin_id == current_user.id
        @poule.destroy
    end
    respond_to do |format|
      format.html { redirect_to rankings_url, notice: "Poule is verwijderd." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poule
      @poule = Poule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poule_params
      params.require(:poule).permit(:name, :description, :publicly_visible, :is_protected, :password)
    end
end
