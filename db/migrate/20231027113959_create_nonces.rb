class CreateNonces < ActiveRecord::Migration[6.1]
  def change
    create_table :nonces do |t|
      t.references :user, null: false, foreign_key: true
      t.string :val, null: false

      t.timestamps
    end
    add_index :nonces, [:user_id, :val], unique: true
  end
end
