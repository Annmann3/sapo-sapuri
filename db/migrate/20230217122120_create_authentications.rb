class CreateAuthentications < ActiveRecord::Migration[6.1]
  def change
    create_table :authentications do |t|
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :token
      t.string :refresh_token
      t.integer :expires_at
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :authentications, %i[uid provider], unique: true
  end
end
