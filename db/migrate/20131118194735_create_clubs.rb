class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.belongs_to :country
      t.timestamps
    end
  end
end
