class SessionsController < ApplicationController
	def create
		auth = request.env['omniauth.auth']
        gotohome = !current_user
		unless @auth = Authorization.find_from_hash(auth)
			#create or add auth to user
			@auth = Authorization.create_from_hash(auth, current_user)
            flash[:newuser] = true
        end
        
        unless current_user
		  self.current_user = @auth.user
        end
        Authorization.validate_avatar(auth, current_user)
        Prediction.prefill_for_user(@auth.user.id)
        flash[:loginnotice] = "Welkom, " + @auth.user.name + "!"
		if gotohome
            redirect_to root_url
        else 
            redirect_to settings_url, notice: "Je kunt vanaf nu ook met " + (I18n.t auth.provider) + " inloggen."
        end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url
	end
end