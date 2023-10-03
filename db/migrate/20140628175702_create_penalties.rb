class CreatePenalties < ActiveRecord::Migration
  def change
    create_table :penalties do |t|
      t.integer :match_id
      t.integer :player_id
      t.boolean :misses

      t.timestamps
    end
  end
end
