class CreateDosages < ActiveRecord::Migration[6.1]
  def change
    create_table :dosages do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :nutrient, foreign_key: true
      t.integer :dosage, null: false
      t.datetime :dosage_at, null: false

      t.timestamps
    end
  end
end
