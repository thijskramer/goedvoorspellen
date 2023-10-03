class Poule < ActiveRecord::Base
    has_many :participations
    has_many :users, :through => :participations

    def self.add_creator_to_poule(user_id, poule_id)
        participation = Participation.new
        participation.user_id = user_id
        participation.poule_id = poule_id
        participation.is_admin = true
        participation.save!
    end

    def ordered_users 
        users.valid.sort { |a,b| b.points <=> a.points }
    end

    def admin_id 
        part = participations.where(:is_admin => true).take
        part.user_id
    end

    def is_participating(user_id)
        users.exists?(user_id)
    end

    def recalculate_total_points
        result = 0
        if users.valid.count > 0
            result = users.sum(:points).to_f / users.valid.count.to_f
        end
        self.points = result.to_f
    end
end
