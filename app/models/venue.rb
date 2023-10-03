class Venue < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged
  has_attached_file :picture, :styles => { :medium => '800x800>', :thumb => '400x400>'}, :default_url => '/images/:style/missing.png'
  has_many :matches, foreign_key: 'stadium_id'
  def slug_candidates
    [
        [:name]
    ]
  end
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |venue|
        csv << venue.attributes.values_at(*column_names)
      end
    end
  end
end
