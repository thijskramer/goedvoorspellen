class Group < ActiveRecord::Base
  require 'GroupRanking' unless Rails.env.production?
  extend FriendlyId
  friendly_id :name, use: :slugged
	has_many :teams

	def rankings
		rankings = Array.new
		self.teams.each do |t| 
		 	ranking = ::GroupRanking.new
		 	ranking.fill(t.id)
			rankings << ranking
        end
        nomatchplayed = true
        rankings.each do |r|
            if r.played > 0
                nomatchplayed = false
            end
        end 
        if nomatchplayed
            rankings.sort_by {|r| r.team.placeholder}
        else
            rankings.sort{ |a,b|
                if a.points == b.points
                    if a.saldo == b.saldo
                        b.scored <=> a.scored
                    else
                        b.saldo <=> a.saldo
                    end
                else
                    b.points <=> a.points
                end
            }
        end
    end

    def matches
        matches = Array.new
        self.teams.each do |t|
            matches = matches + t.matches
        end
        matches.uniq.select{|x| x.matchtype_id == 1 }.sort { |x,y| x.startDate <=> y.startDate }
    end
end
