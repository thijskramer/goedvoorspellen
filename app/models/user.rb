class User < ActiveRecord::Base
  rolify
	has_many :authorizations
    has_many :predictions
    has_many :participations
    has_many :poules, :through => :participations
    has_many :avatars
    belongs_to :avatar, :class_name => 'Avatar', foreign_key: 'preferred_avatar'
    scope :valid, -> { where(deleted: nil) }
	def self.create_from_hash!(hash)
		create(
			:name => hash.info.name,
			:email => (hash.info.email if hash.info.email != nil),
            :public_name => hash.info.first_name,
            :avatar_visibility => "PUBLIC"
		)
	end

    # def points
    #     
    # end

    def displayname 
        #todo: let user configure their displayname
        self.name
    end
    def publicname 
        if public_name && public_name.length > 0
            public_name
        else 
            self.name
        end
    end

    def image
        if preferred_avatar && avatar
            avatar.url
        else 
            avatars.first.url
        end
    end

    def poule_ids 
        self.poules.pluck(:id)
    end

    def is_in_same_poule(poule_id_list)
        result = false
        poule_ids.each do |p| 
            if poule_id_list.include?(p)
                result = true
            end
        end 
        result
    end

    def recalculate_total_points
        self.points = predictions.sum(:points)
    end

    def unpredicted_known_matches 
        num = 0
        predictions.each do |p|
            if p.home_score == nil && p.away_score == nil
                unless p.match.hometeam_id == nil || p.match.awayteam_id == nil
                    unless p.match.started
                        num += 1
                    end
                end
            end
        end
        num
    end
end
