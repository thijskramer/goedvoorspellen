class AddPropsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :image, :string
  	add_column :users, :location, :string
  	add_column :users, :gender, :string
  end
end
