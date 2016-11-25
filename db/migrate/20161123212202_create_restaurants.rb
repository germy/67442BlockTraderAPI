class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.decimal :latitude
      t.decimal :longitude
      t.string :address
      t.string :hours

      t.timestamps
    end
  end
end
