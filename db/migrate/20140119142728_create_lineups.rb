class CreateLineups < ActiveRecord::Migration
  def change
    create_table :lineups do |t|
      t.integer :match_id
      t.integer :team_id
      t.integer :player_id

      t.timestamps
    end
  end
end
