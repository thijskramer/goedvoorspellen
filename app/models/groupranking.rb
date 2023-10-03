class GroupRanking
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :attributes, :team, :team_id, :played, :won, :draw, :lost, :scored, :received, :points, :saldo
  # belongs_to :team
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  def fill(team_id)
    process(team_id)
  end
  
  private 
    def process(team_id)
      self.won = 0
      self.draw = 0
      self.lost = 0
      self.scored = 0
      self.received = 0
      @team = Team.find(team_id)
      self.team = team
      matches = team.groupmatches
      if matches.length > 0
        matches.each do |m|
          if m.winner == nil
            self.draw += 1
          elsif m.winner != nil && m.winner.id == team.id
            self.won += 1
          else 
            self.lost += 1
          end
          if m.hometeam_id == team.id
            self.scored += m.homeScore
            self.received += m.awayScore
          end
          if m.awayteam_id == team.id
            self.scored += m.awayScore
            self.received += m.homeScore
          end
        end
      end
      self.played = self.won + self.draw + self.lost
      self.points = (self.won * 3) + self.draw
      self.saldo = self.scored - self.received
    end
end