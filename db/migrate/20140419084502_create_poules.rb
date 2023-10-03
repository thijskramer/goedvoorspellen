class CreatePoules < ActiveRecord::Migration
  def change
    create_table :poules do |t|
      t.string :name
      t.text :description
      t.boolean :is_protected
      t.string :password

      t.timestamps
    end
  end
end
