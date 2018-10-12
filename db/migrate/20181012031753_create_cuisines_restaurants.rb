class CreateCuisinesRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_join_table :cuisines, :restaurants do |t|
      t.index :cuisine_id
      t.index :restaurant_id
    end
  end
end
