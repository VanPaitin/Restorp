class AddLockVersionToMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :lock_version, :integer, default: 0
  end
end
