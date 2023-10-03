class Coach < ActiveRecord::Base
	belongs_to :country
	has_one :team

	def fullname
		firstName + ' ' + lastName
	end
end
