class CreateReferees < ActiveRecord::Migration
  def change
    create_table :referees do |t|
      t.string :firstName
      t.string :lastName
      t.date :dateOfBirth
      t.integer :country_id
      t.boolean :isActive

      t.timestamps
    end
  end
end
