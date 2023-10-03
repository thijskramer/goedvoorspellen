class Referee < ActiveRecord::Base
	belongs_to :country
	has_many :matches
	def name 
		firstName + " " + lastName
	end

    def redcards
        redcards = 0
        matches.each do |m|
            m.bookings.each do |b|
                if b.is_red_card || b.is_yellow_red_card
                    redcards += 1
                end
            end
        end
        redcards
    end
    def yellowcards
        yellowcards = 0
        matches.each do |m|
            m.bookings.each do |b|
                if b.is_yellow_card
                    yellowcards += 1
                end
            end
        end
        yellowcards
    end

    def ranking 
        (redcards * 3) + yellowcards
    end
end
