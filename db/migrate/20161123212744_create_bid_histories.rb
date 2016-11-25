class CreateBidHistories < ActiveRecord::Migration
  def change
    create_table :bid_histories do |t|
      t.integer :user_id
      t.integer :order_id
      t.decimal :price

      t.timestamps
    end
  end
end
