class AddEmailAndRemoveProviderFromUser < ActiveRecord::Migration
  def change
  	remove_column :users, :provider
  	add_column :users, :email, :string
  end
end
