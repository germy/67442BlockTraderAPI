class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.decimal :original_price
      t.integer :resturant_id

      t.timestamps
    end
  end
end
