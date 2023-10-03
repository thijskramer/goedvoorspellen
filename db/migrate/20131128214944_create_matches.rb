class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :number
      t.integer :matchtype_id
      t.integer :hometeam_id
      t.integer :awayteam_id
      t.string :homePlaceholder
      t.string :awayPlaceholder
      t.integer :homeScore
      t.integer :awayScore
      t.integer :stadium_id
      t.integer :referee_id
      t.datetime :startDate
      t.integer :startDateUtcOffset

      t.timestamps
    end
  end
end
