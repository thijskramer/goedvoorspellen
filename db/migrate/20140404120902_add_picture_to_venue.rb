class AddPictureToVenue < ActiveRecord::Migration
  def self.up
    add_attachment :venues, :picture
  end

  def self.down
    add_attachment :venues, :picture
  end
end
