class Prediction < ActiveRecord::Base
    belongs_to :user
    belongs_to :match
    def calculate_points
        match = self.match
        points = 0
        unless match.homeScore.nil? || match.awayScore.nil? || self.home_score.nil? || self.away_score.nil?
            if match.homeScore == self.home_score && match.awayScore == self.away_score
                points = 10
            else 
                # toto
                if match.homeScore > match.awayScore && self.home_score > self.away_score
                    points += 5 # thuiswinst
                end
                if match.homeScore < match.awayScore && self.home_score < self.away_score
                    points += 5 # uitwinst
                end
                if match.homeScore == match.awayScore && self.home_score == self.away_score
                    points += 5 # gelijkspel
                end
                if match.homeScore == self.home_score
                    points += 2
                end
                if match.awayScore == self.away_score
                    points += 2
                end
            end
            self.points = points
        end
    end
    
    def self.prefill_for_user(user_id)
        unless Prediction.where(user_id: user_id).any?
            Match.find_each do |m|
                if m.startDate > DateTime.now
                    prediction = Prediction.new
                    prediction.user_id = user_id
                    prediction.match_id = m.id
                    prediction.save
                end
            end
        end
    end 
end
