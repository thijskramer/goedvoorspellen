class Lineup < ActiveRecord::Base
  belongs_to :team
  belongs_to :match
  belongs_to :player

  def name 
  	self.player.name
  end
end
