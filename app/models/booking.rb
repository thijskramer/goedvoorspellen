class Booking < ActiveRecord::Base
	belongs_to :match
	belongs_to :player
	def is_yellow_red_card
		bookings = Booking.where("match_id = ? AND player_id = ? AND is_yellow_card = ?", self.match_id, self.player_id, true).order('(minute + plus_extra_time) ASC')
		if bookings.length == 2
			res = bookings.first.id != self.id
			res
		end
	end
end
