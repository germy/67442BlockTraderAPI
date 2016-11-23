class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :fb_id
    

      t.string :api_authtoken
      t.datetime :authtoken_expiry
      
      t.timestamps
    end
  end
end
