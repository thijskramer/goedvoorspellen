class RemoveUtcOffsetFromMatch < ActiveRecord::Migration
  def change
  	remove_column :matches, :startDateUtcOffset
  end
end
