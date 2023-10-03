class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :firstName
      t.string :lastName
      t.integer :country_id

      t.timestamps
    end
  end
end
