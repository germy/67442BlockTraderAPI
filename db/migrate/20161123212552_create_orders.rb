class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :food_order_id
      t.integer :customer_id
      t.integer :provider_id
      t.string :address
      t.decimal :latitude
      t.decimal :longitude
      t.string :delivery_status
      t.string :payment_id_user
      t.string :payment_id_receiever

      t.timestamps
    end
  end
end
