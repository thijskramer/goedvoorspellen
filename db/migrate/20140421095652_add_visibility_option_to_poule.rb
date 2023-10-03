class AddVisibilityOptionToPoule < ActiveRecord::Migration
  def change
    add_column :poules, :publicly_visible, :boolean
  end
end
