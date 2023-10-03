class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :firstName
      t.string :lastName
      t.integer :country_id
      t.string :position
      t.integer :club_id
      t.integer :number
      t.boolean :isCaptain
      t.boolean :isViceCaptain
      t.integer :caps
      t.integer :goals
      t.date :dateOfBirth
      t.boolean :inSquad

      t.timestamps
    end
  end
end
