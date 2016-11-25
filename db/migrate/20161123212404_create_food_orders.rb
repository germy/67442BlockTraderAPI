class CreateFoodOrders < ActiveRecord::Migration
  def change
    create_table :food_orders do |t|
      t.integer :food_id
      t.integer :order_id

      t.timestamps
    end
  end
end
