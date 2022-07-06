class CreateNutrients < ActiveRecord::Migration[6.1]
  def change
    create_table :nutrients do |t|
      t.string :name, limit: 30, null: false, index: { unique: true }
      t.integer :graph_type, null: false
      t.string :dosage_recommendation, limit: 120, null: false
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
      t.float :vdf
      t.float :ke
      t.float :ka
      t.string :default_unit

      t.timestamps
    end
  end
end
