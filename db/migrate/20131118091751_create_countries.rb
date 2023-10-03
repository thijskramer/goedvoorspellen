class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :dutchName
      t.string :isoAlpha2Code
      t.string :isoAlpha3Code
      t.integer :isoNumericCode
      t.string :FIFAcode

      t.timestamps
    end
  end
end
