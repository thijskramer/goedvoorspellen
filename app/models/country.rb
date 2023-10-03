class Country < ActiveRecord::Base
	has_many :players
	belongs_to :team
	has_many :clubs
	has_many :referees
end
