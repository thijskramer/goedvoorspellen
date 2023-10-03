class HomeController < ApplicationController
  require 'timespan'
  
  def index
    @lastmatch = Match.where("startDate < ?", DateTime.now).order(startDate: :desc).take
    @nextmatch = Match.where("startDate > ?", DateTime.now).order(startDate: :asc).take
    if current_user
        @points = current_user.points
        @lastpredictions = current_user.predictions.joins(:match).where('matches.startDate < ?', DateTime.now).order('matches.startDate DESC').take(3)
        @numUnpredictedMatches = current_user.unpredicted_known_matches
        firstUpcomingUnpredictedMatch = current_user.predictions.joins(:match).where('home_score IS NULL AND away_score IS NULL AND matches.startDate > ?', DateTime.now).order('matches.startDate ASC').take
        unless firstUpcomingUnpredictedMatch.nil?
            @timeRemainingToPredict = Time.diff(DateTime.now, firstUpcomingUnpredictedMatch.match.startDate)
        end
    end
  end

    def help
        
    end

    def placeholder
      
    end
end