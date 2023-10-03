class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :country_id
      t.integer :FIFAranking
      t.string :associationFull
      t.string :associationAbbreviation
      t.integer :coach_id

      t.timestamps
    end
  end
end
