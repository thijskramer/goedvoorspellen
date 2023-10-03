OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '154944534595480', '5642a18afbc58628c1c7303ba9836975', 
		:scope => 'email,user_location'
	provider :gplus, '225579393340.apps.googleusercontent.com', 'dIbx_AMVeFsOY--WEHg95pHv', 
		scope: 'userinfo.email, userinfo.profile'
    provider :twitter, "Ju8aP5z7ZeigKzWG2Lc0RkUL2", "gmvK15JXrss7DopZR6FMEGe3mrqrIKSZhKYUarTJ1NFCxtUOX8",
        {
          :secure_image_url => 'true',
          :image_size => 'normal',
          :authorize_params => {
            :lang => 'nl'
          }
        }
end