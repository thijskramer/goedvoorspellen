class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :player_id
      t.integer :match_id
      t.integer :minute
      t.integer :plus_extra_time
      t.boolean :is_penalty
      t.boolean :is_own_goal

      t.timestamps
    end
  end
end
