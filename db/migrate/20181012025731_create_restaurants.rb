class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.references :city, foreign_key: true
      t.boolean :is_active
      t.string :name
      t.string :description
      t.string :logo
      t.integer :rating
      t.integer :review_number
      t.string :address
      t.integer :post_code
      t.float :latitude
      t.float :longitude
      t.boolean :is_delivery_enabled
      t.boolean :is_pickup_enabled
      t.boolean :is_preorder_enabled
      t.string :web_path
      t.string :url_key
      t.boolean :is_new
      t.jsonb :schedules

      t.timestamps
    end

    add_index :restaurants, :schedules, using: :gin
  end
end
