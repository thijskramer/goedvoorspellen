class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :match_id
      t.integer :player_id
      t.integer :minute
      t.integer :plus_extra_time
      t.boolean :is_yellow_card
      t.boolean :is_red_card

      t.timestamps
    end
  end
end
