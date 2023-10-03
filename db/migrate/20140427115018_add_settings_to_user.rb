class AddSettingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :preferred_avatar, :integer
    remove_column :users, :image
    add_column :users, :public_name, :string
    add_column :users, :avatar_visibility, :string
  end
end
