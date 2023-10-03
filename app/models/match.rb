class Match < ActiveRecord::Base
	belongs_to :match_type, foreign_key: 'matchtype_id'
	belongs_to :hometeam, :class_name => 'Team', foreign_key: 'hometeam_id'
	belongs_to :awayteam, :class_name => 'Team', foreign_key: 'awayteam_id'
	belongs_to :stadium, :class_name => 'Venue', foreign_key: 'stadium_id'
	belongs_to :referee
  has_many :lineups
  has_many :scores
  has_many :substitutes
  has_many :bookings
  has_many :predictions
  has_many :penalties
  after_update :update_predictions


  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged

  def type 
	match_type.name
  end

  def name
    home = ''
    away = ''
    if hometeam_id.nil?
      home = homePlaceholder
    else
      home = hometeam.name
    end
    if awayteam_id.nil?
      away = awayPlaceholder
    else
      away = awayteam.name
    end
    home + ' - ' + away
  end

  def slugname
  	name.sub(' - ', '-')
  end

  def slug_candidates
    [
        :slugname,
        [:number, :slugname]
    ]
  end

	def group
		group = "";
		hasname = false;
		if hometeam_id != nil
			if hometeam.group_id != nil
				group = hometeam.group.name
				hasname = true
			end
		end
		if !hasname && awayteam_id != nil
			if awayteam.group_id != nil
				group = awayteam.group.name
				hasname = true
			end
		end
        unless hasname
          group = '?'
        end
		group
	end
    
	def winner
        theteam = nil
		unless homeScore.nil? || awayScore.nil?
			if homeScore > awayScore
				theteam = hometeam
			end
			if awayScore > homeScore
				theteam = awayteam
			end
		else
			theteam = nil
		end
        theteam
	end
	def played
		endDate.to_i < DateTime.now.in_time_zone("Amsterdam").to_i # startdatum + 105 minuten
	end

    def started
        DateTime.now.in_time_zone("Amsterdam") > self.startDate
    end

    def done 
        DateTime.now.in_time_zone("Amsterdam") > self.endDate
    end

    def nowplaying 
        started && !done
    end

    def endDate
        date = self.startDate + 110.minutes
        if self.matchtype_id > 1
            if self.homeScore == self.awayScore
                date = self.startDate + 170.minutes
            end
        end
        date
    end

	def homelineups
		lineups.where(:team_id => hometeam_id)
	end
	def awaylineups
		lineups.where(:team_id => awayteam_id)
	end
	
	def homegoals
		home = Array.new
		scores.each do |s|			
			# alle scores waar hometeam == player.team en alle scores waar hometeam != player.team && owngoal == true
			if s.is_own_goal == false && hometeam.players.exists?(:id => s.player_id)
				home << s
			else
				if s.is_own_goal == true && awaylineups.exists?(:player_id => s.player_id)
					home << s
				end
			end
		end
		home.sort{ |a, b| (a.minute + (a.plus_extra_time == nil ? 0 : a.plus_extra_time)) <=> (b.minute + (b.plus_extra_time == nil ? 0 : b.plus_extra_time)) }
	end
	def awaygoals
		away = Array.new
		scores.each do |s| 
			# alle scores waar hometeam == player.team en alle scores waar hometeam != player.team && owngoal == true
			if s.is_own_goal == false && awayteam.players.exists?(:id => s.player_id)
				away << s
			else
				if s.is_own_goal == true && homelineups.exists?(:player_id => s.player_id)
					away << s
				end
			end
		end
		away.sort{ |a, b| (a.minute + (a.plus_extra_time == nil ? 0 : a.plus_extra_time)) <=> (b.minute + (b.plus_extra_time == nil ? 0 : b.plus_extra_time)) }
	end

	def homebookings
		bookings = Array.new
		self.bookings.each do |b|
			 if hometeam.players.exists?(:id => b.player_id)
			 	bookings << b
			 end
		end
		bookings
	end
	def awaybookings 
		bookings = Array.new
		self.bookings.each do |b|
			 if awayteam.players.exists?(:id => b.player_id)
			 	bookings << b
			 end
		end
		bookings
	end

    def homepenalties
        home = Array.new
        penalties.each do |s|          
            if hometeam.players.exists?(:id => s.player_id)
                home << s
            end
        end
        home
    end

    def homepenalties_scored
        home = Array.new
        penalties.each do |s|          
            if hometeam.players.exists?(:id => s.player_id) && s.misses != true
                home << s
            end
        end
        home.length
    end

    def awaypenalties
        away = Array.new
        penalties.each do |s|          
            if awayteam.players.exists?(:id => s.player_id)
                away << s
            end
        end
        away
    end

    def awaypenalties_scored
        away = Array.new
        penalties.each do |s|          
            if awayteam.players.exists?(:id => s.player_id) && s.misses != true
                away << s
            end
        end
        away.length
    end

	def update_scores
		self.homeScore = homegoals.length
		self.awayScore = awaygoals.length
		self.save!
	end

    def update_predictions
        #if self.done
            self.predictions.each do |p|
                p.calculate_points
                p.save!
            end
            User.valid.find_each do |user|
              user.recalculate_total_points
              user.save!
            end
            Poule.find_each do |poule|
                poule.recalculate_total_points
                poule.save!
            end
        #end
    end
end
