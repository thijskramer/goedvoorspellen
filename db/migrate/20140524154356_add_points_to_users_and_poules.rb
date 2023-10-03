class AddPointsToUsersAndPoules < ActiveRecord::Migration
  def change
    add_column :users, :points, :integer
    add_column :poules, :points, :decimal, precision: 6, scale: 3
  end
end
