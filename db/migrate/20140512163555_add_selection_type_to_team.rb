class AddSelectionTypeToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :selection_type, :string
  end
end
