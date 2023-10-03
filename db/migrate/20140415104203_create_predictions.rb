class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.integer :match_id
      t.integer :user_id
      t.integer :home_score
      t.integer :away_score

      t.timestamps
    end
  end
end
