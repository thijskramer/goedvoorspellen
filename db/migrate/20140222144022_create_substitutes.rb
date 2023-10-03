class CreateSubstitutes < ActiveRecord::Migration
  def change
    create_table :substitutes do |t|
      t.integer :match_id
      t.integer :player_out_id
      t.integer :player_in_id
      t.integer :minute
      t.integer :plus_extra_time

      t.timestamps
    end
  end
end
