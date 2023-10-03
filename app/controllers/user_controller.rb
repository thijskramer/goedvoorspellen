class UserController < ApplicationController
  before_action :set_user, only: [:settings, :update, :remove]
  def settings
    @available_avatars = @user.avatars
    @coupled_providers = @user.authorizations.pluck(:provider)
    is_poule_admin = false
    @user.poules.each do |p|
        if is_poule_admin == false && (p.admin_id == current_user.id)
            is_poule_admin = true
        end
    end
    @is_poule_admin = is_poule_admin
  end

  def update 
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to settings_url, notice: 'Je instellingen zijn opgeslagen.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @poule.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove
    # disable authorizations
    @user.authorizations.each do |auth| 
        auth.provider = "DEL-" + auth.provider
        auth.save
    end
    # remove poule coupling
    @user.participations.each do |p|
        p.destroy!
    end

    # remove avatars
    @user.avatars.each do |a|
        a.destroy!
    end

    # keep predictions so that accidentally deleted accounts can be restored.

    # disable user.
    @user.deleted = true

    @user.save!
    redirect_to signout_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :public_name, :preferred_avatar, :avatar_visibility)
    end
end
