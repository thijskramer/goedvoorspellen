class AddPlaceholderToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :placeholder, :string
  end
end
