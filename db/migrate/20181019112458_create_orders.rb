class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.decimal :total_price
      t.string :status, default: 'pending'
      t.string :tracking_id

      t.timestamps
    end

    add_index :orders, :tracking_id, unique: true
  end
end
