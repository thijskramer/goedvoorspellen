class Team < ActiveRecord::Base
	belongs_to :coach
	belongs_to :country
	belongs_to :group
	has_many :home_matches, :class_name => 'Match', :foreign_key => 'hometeam_id'
	has_many :away_matches, :class_name => 'Match', :foreign_key => 'awayteam_id'
  
  has_attached_file :logo, :styles => { :medium => '300x300>', :thumb => '100x100>'}, :default_url => '/images/:style/missing.png'
  extend FriendlyId
  friendly_id :name, :use => :slugged
  #attr_accessor :wkgoals, :cardindex, :yellowcards, :redcards
	def matches
		home_matches | away_matches
	end
	def name 
		country.dutchName
  end
  def players
    self.country.players.where(:inSquad => true)
  end
  def average_age
    ages = 0
    players.each do |p|
      ages += p.age
    end
    (ages.to_f / players.length).to_f
  end
  def keepers
    players.where(:position => 'Keeper')
  end
  def defenders
    players.where(:position => 'Verdediger')
  end
  def midfielders
    players.where(:position => 'Middenvelder')
  end
  def attackers
    players.where(:position => 'Aanvaller')
  end

  def wkgoals
    goals = 0
    matches.each do |m|
        if m.hometeam_id == self.id
            goals += (m.homeScore.nil? ? 0 : m.homeScore)
        end
        if m.awayteam_id == self.id
            goals += (m.awayScore.nil? ? 0 : m.awayScore)
        end
    end
    goals
  end

  def redcards
    red = 0
    players.each do |p|
        p.bookings.each do |b|
            if b.is_red_card || b.is_yellow_red_card
                red += 1
            end
        end
    end
    red
  end

  def yellowcards
    yellow = 0
    players.each do |p|
        p.bookings.each do |b|
            if b.is_yellow_card
                yellow += 1
            end
        end
    end
    yellow
  end

	def groupmatches
		gm = Array.new
		matches.each do |m|
			if m.matchtype_id == 1 && m.played
				gm << m
			end
		end
		gm
  end

  def avgcaps 
    totalcaps = 0
    players.each do |p|
        totalcaps += p.computed_caps
    end
    avg = totalcaps.to_f / 23
    avg
  end
  
  def captain 
     players.where(:isCaptain => true).take
  end 
  def stillplaying
    matches.select { |m| m.startDate > DateTime.now }.length > 0
  end
end
