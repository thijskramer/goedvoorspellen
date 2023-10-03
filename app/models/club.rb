class Club < ActiveRecord::Base
	belongs_to :country
	has_many :players
	def ddlName
		name + " (" + country.dutchName + ")"
	end

    def wkplayers
        teamIds = Team.pluck(:country_id)
        players.where(inSquad: true, country_id: (teamIds)).order(:country_id)
    end
end
