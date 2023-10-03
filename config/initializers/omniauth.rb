OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  fb_app_id = ''
  fb_app_secret = ''
  gplus_app_id = ''
  gplus_app_secret = ''
  tw_app_id = ""
  tw_app_secret = ""
	provider :facebook, fb_app_id, fb_app_secret,
		:scope => 'email,user_location'
	provider :gplus, gplus_app_id, gplus_app_secret,
		scope: 'userinfo.email, userinfo.profile'
    provider :twitter, tw_app_id, tw_app_secret,
        {
          :secure_image_url => 'true',
          :image_size => 'normal',
          :authorize_params => {
            :lang => 'nl'
          }
        }
end
