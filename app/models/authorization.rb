class Authorization < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :user_id, :uid, :provider
	validates_uniqueness_of :uid, :scope => :provider
    #require 'GroupRanking' unless Rails.env.production?

	def self.find_from_hash(hash)
		find_by_provider_and_uid(hash['provider'], hash['uid'])
	end

	def self.create_from_hash(hash, user = nil) 
		user ||= User.create_from_hash!(hash)
		auth = Authorization.create(
			:user => user, 
			:uid => hash['uid'], 
			:provider => hash['provider'],
			:oauth_token => hash.credentials.token,
			:oauth_expires_at => hash.credentials.expires_at
		)
        unless Avatar.exists?(:provider => hash.provider, :user_id => user.id)
            Avatar.create(:url => hash.info.image, :provider => hash.provider, :user_id => user.id)        
        end
        auth
	end

    def self.validate_avatar(hash, user = nil)
        if user
            unless Avatar.exists?(:provider => hash.provider, :user_id => user.id)
                Avatar.create(:url => hash.info.image, :provider => hash.provider, :user_id => user.id)     
            end
        end
    end
end
