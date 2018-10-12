class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.string :name
      t.string :description
      t.integer :number_in_stock
      t.decimal :price
      t.references :restaurant, foreign_key: true
      t.references :cuisine, foreign_key: true

      t.timestamps
    end
  end
end
