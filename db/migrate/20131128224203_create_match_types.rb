class CreateMatchTypes < ActiveRecord::Migration
  def change
    create_table :match_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
