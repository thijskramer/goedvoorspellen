class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :poule_id
      t.boolean :is_admin

      t.timestamps
    end
  end
end
