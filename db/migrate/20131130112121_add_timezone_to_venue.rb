class AddTimezoneToVenue < ActiveRecord::Migration
  def change
  	add_column :venues, :timezone, :string
  end
end
