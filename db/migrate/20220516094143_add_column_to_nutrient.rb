class AddColumnToNutrient < ActiveRecord::Migration[6.1]
  def change
    add_column :nutrients, :vdf, :float
    add_column :nutrients, :ke, :float
    add_column :nutrients, :ka, :float
    add_column :nutrients, :default_unit, :string

    remove_column :nutrients, :graph_constant, :integer
  end
end
