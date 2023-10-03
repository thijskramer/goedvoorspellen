class AddDeletedFlagToUsersAndAuthorizations < ActiveRecord::Migration
  def change
    add_column :users, :deleted, :boolean
    add_column :authorizations, :deleted, :boolean
  end
end
