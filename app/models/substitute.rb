class Substitute < ActiveRecord::Base
	belongs_to :player_out, :class_name => 'Player', foreign_key: 'player_out_id'
	belongs_to :player_in, :class_name => 'Player', foreign_key: 'player_in_id'
	belongs_to :match
end
