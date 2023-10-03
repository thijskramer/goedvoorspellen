class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.string :oauth_token
      t.string :oauth_expires_at
      t.timestamps
    end
  end
end
