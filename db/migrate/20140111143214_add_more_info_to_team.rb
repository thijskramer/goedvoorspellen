class AddMoreInfoToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :appearances, :string
    add_column :teams, :best_result, :string
  end
end
