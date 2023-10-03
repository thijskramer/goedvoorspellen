class Player < ActiveRecord::Base
	belongs_to :club
	belongs_to :country
	has_many :scores
	has_many :lineups
	has_many :substitutions_out, :class_name => 'Substitute', :foreign_key => 'player_out_id'
	has_many :substitutions_in, :class_name => 'Substitute', :foreign_key => 'player_in_id'
	has_many :bookings
    has_many :penalties
  extend FriendlyId
  friendly_id :fullname, :use => :slugged
	def fullname
  		firstName + ' ' + lastName
	end
	def name 
		fullname
	end
    def name_and_number 
        ret = fullname
        unless number.nil?
            ret = number.to_s + ". " + fullname
        end
        ret
    end
	def team
		Team.where(country_id: self.country_id).first
	end
	def positionId
		if position == 'Keeper'
			1
		elsif position == 'Verdediger'
			2
		elsif position == 'Middenvelder'
			3
		else
			4
		end
  end
  def age
      now = Time.now.utc.to_date
      now.year - dateOfBirth.year - ((now.month > dateOfBirth.month || (now.month == dateOfBirth.month && now.day >= dateOfBirth.day)) ? 0 : 1)
  end
  def wkgoals 
  	scores.where(is_own_goal: false)
  end 
  def groupgoals(match_ids)
  	scores.where(is_own_goal: false, match_id: match_ids)
  end
  def yellowcards 
  	bookings.where(is_yellow_card: true)
  end
  def redcards 
  	bookings.where(is_red_card: true)
  end

  def computed_caps
    self.caps + lineups.count + substitutions_in.count
  end

  def computed_goals
    self.goals + self.wkgoals.count
  end
end
